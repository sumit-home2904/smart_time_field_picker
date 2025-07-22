import 'dart:async';
import 'dart:io';
import 'animated_section.dart';
import 'time_picker_decoration.dart';
import 'package:flutter/material.dart';

/// A widget that builds a custom dropdown overlay for displaying a list of items.
///
/// The overlay is positioned using a [LayerLink] and can be fully customized
/// with width, height, styling, and behavior. It supports both keyboard and
/// pointer navigation.
class OverlayBuilder<T> extends StatefulWidget {
  /// The list of items to display in the overlay.
  final List<T> item;

  /// The initially selected item.
  final T? initialItem;

  /// The index of the currently focused item.
  final int focusedIndex;

  /// The width of the dropdown menu.
  final double? menuWidth;

  /// The elevation of the dropdown card.
  final double? elevation;

  /// The height of the dropdown menu.
  final double? menuHeight;

  /// Whether the associated text field is read-only.
  final bool fieldReadOnly;

  /// Link to the composited layer where this overlay should attach.
  final LayerLink layerLink;

  /// The text style used to display items.
  final TextStyle textStyle;

  /// The radius of the text cursor (if applicable).
  final Radius? cursorRadius;

  /// The render box of the anchor widget, used to determine width.
  final RenderBox? renderBox;

  /// Key used to identify the currently focused item in the list.
  final GlobalKey itemListKey;

  /// The offset for positioning the dropdown relative to its anchor.
  final Offset? dropdownOffset;

  /// Padding around the list of items in the overlay.
  final EdgeInsets? listPadding;

  /// Callback triggered when the focused index changes.
  final Function(int) changeIndex;

  /// Whether keyboard navigation is currently active.
  final bool isKeyboardNavigation;

  /// Callback triggered when an item is selected.
  final Function(T? value) onChanged;

  /// Callback to update the hover/keyboard navigation flag.
  final Function(bool) changeKeyBool;

  /// Scroll controller for the list of items.
  final ScrollController scrollController;

  /// Controller to show or hide the overlay.
  final OverlayPortalController controller;

  /// Callback triggered when a list item is tapped.
  final Function(int? value) onItemSelected;

  /// Optional styling and decoration for the dropdown menu.
  final TimePickerDecoration? timePickerDecoration;

  /// Creates an [OverlayBuilder].
  const OverlayBuilder({
    super.key,
    this.menuWidth,
    this.renderBox,
    this.menuHeight,
    this.listPadding,
    this.initialItem,
    this.cursorRadius,
    this.elevation = 0,
    required this.item,
    this.dropdownOffset,
    required this.textStyle,
    required this.layerLink,
    required this.onChanged,
    required this.controller,
    required this.itemListKey,
    this.timePickerDecoration,
    required this.changeIndex,
    required this.focusedIndex,
    this.fieldReadOnly = false,
    required this.changeKeyBool,
    required this.onItemSelected,
    required this.scrollController,
    required this.isKeyboardNavigation,
  });

  @override
  State<OverlayBuilder<T>> createState() => _OverlayOutBuilderState<T>();
}

class _OverlayOutBuilderState<T> extends State<OverlayBuilder<T>> {
  T? selectedItem;
  bool displayOverlayBottom = true;

  final GlobalKey errorButtonKey = GlobalKey();
  final key1 = GlobalKey(), key2 = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialItem != null) {
        selectedItem = (widget.initialItem as T);
      }
      checkRenderObjects(); // Start checking render objects.
    });
  }

  /// Checks whether the overlay should be displayed above or below the anchor
  /// based on available screen space.
  void checkRenderObjects() {
    if (key1.currentContext != null && key2.currentContext != null) {
      final RenderBox? render1 =
          key1.currentContext?.findRenderObject() as RenderBox?;
      final RenderBox? render2 =
          key2.currentContext?.findRenderObject() as RenderBox?;

      if (render1 != null && render2 != null) {
        final screenHeight = MediaQuery.of(context).size.height;
        double y = render1.localToGlobal(Offset.zero).dy;

        if (Platform.isAndroid || Platform.isIOS) {
          if (screenHeight - y - (MediaQuery.of(context).size.height * 0.4) <
              render2.size.height) {
            displayOverlayBottom = false;
          }
        } else {
          if (screenHeight - y < render2.size.height) {
            displayOverlayBottom = false;
          }
        }

        setState(() {}); // Update the state after calculation.
      }
    }
  }

  @override
  void didUpdateWidget(covariant OverlayBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialItem != oldWidget.initialItem) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          selectedItem = (widget.initialItem as T);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformFollower(
      link: widget.layerLink,
      offset: setOffset(),
      followerAnchor:
          displayOverlayBottom ? Alignment.topLeft : Alignment.bottomLeft,
      child: LayoutBuilder(
        builder: (context, c) {
          return SizedBox(
            height: widget.menuHeight ?? 150,
            width:
                widget.menuWidth ?? widget.renderBox?.size.width ?? c.maxWidth,
            child: Card(
              elevation: widget.elevation,
              color: Colors.blue,
              margin: EdgeInsets.zero,
              child: Container(
                key: key1,
                height: widget.menuHeight ?? 150,
                decoration: menuDecoration(),
                child: AnimatedSection(
                  expand: true,
                  animationDismissed: widget.controller.hide,
                  axisAlignment: displayOverlayBottom ? 1.0 : -1.0,
                  child: Container(
                    key: key2,
                    height: widget.menuHeight ?? 150,
                    width: MediaQuery.sizeOf(context).width,
                    child: uiListWidget(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Builds the list of items in the dropdown menu with hover and tap handling.
  Widget uiListWidget() {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (notification) {
        notification.disallowIndicator();
        return true;
      },
      child: Column(
        children: [
          Expanded(
            child: Listener(
              onPointerSignal: (event) {
                SearchTimerMethod(milliseconds: 300).run(() {
                  RenderBox? renderBox = widget.itemListKey.currentContext
                      ?.findRenderObject() as RenderBox?;
                  final double itemHeight = renderBox?.size.height ?? 30;

                  final double firstVisibleIndex =
                      widget.scrollController.offset / itemHeight;

                  final int museCourse =
                      ((event.localPosition.dy / itemHeight) - 1).ceil();

                  final int scrollIndex =
                      firstVisibleIndex.toInt() + museCourse;
                  widget.changeIndex(scrollIndex);
                });
              },
              child: ListView.builder(
                controller: widget.scrollController,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: false,
                padding:
                    widget.listPadding ?? EdgeInsets.symmetric(vertical: 4),
                itemCount: widget.item.length,
                itemBuilder: (_, index) {
                  bool selected = widget.focusedIndex == index;
                  return MouseRegion(
                    onHover: (event) {
                      widget.changeKeyBool(false);
                    },
                    onEnter: (event) {
                      if (!widget.isKeyboardNavigation) {
                        widget.changeIndex(index);
                      }
                    },
                    child: InkWell(
                      key: widget.focusedIndex == index
                          ? widget.itemListKey
                          : null,
                      onTap: () => widget.onItemSelected(index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        margin: EdgeInsets.fromLTRB(5, 2, 5, 1),
                        decoration: BoxDecoration(
                          color: selected
                              ? widget.timePickerDecoration?.hoverColor ??
                                  Colors.green
                              : Colors.transparent,
                          borderRadius:
                              widget.timePickerDecoration?.borderRadius ??
                                  BorderRadius.circular(2),
                        ),
                        child: Text(
                          "${widget.item[index]}",
                          locale: widget
                              .timePickerDecoration?.pickerTextStyle?.locale,
                          maxLines: widget
                              .timePickerDecoration?.pickerTextStyle?.maxLines,
                          textAlign: widget
                              .timePickerDecoration?.pickerTextStyle?.textAlign,
                          textDirection: widget.timePickerDecoration
                              ?.pickerTextStyle?.textDirection,
                          style: TextStyle(
                            fontSize: widget.timePickerDecoration
                                ?.pickerTextStyle?.fontSize,
                            height: widget
                                .timePickerDecoration?.pickerTextStyle?.height,
                            letterSpacing: widget.timePickerDecoration
                                ?.pickerTextStyle?.letterSpacing,
                            fontFamily: widget.timePickerDecoration
                                ?.pickerTextStyle?.fontFamily,
                            color: selected
                                ? widget.timePickerDecoration?.pickerTextStyle
                                        ?.hoverColor ??
                                    Colors.white
                                : widget.timePickerDecoration?.pickerTextStyle
                                        ?.color ??
                                    Colors.black,
                            fontWeight: widget.timePickerDecoration
                                ?.pickerTextStyle?.fontWeight,
                            fontStyle: widget.timePickerDecoration
                                ?.pickerTextStyle?.fontStyle,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Returns the decoration for the dropdown container.
  BoxDecoration menuDecoration() {
    return widget.timePickerDecoration?.menuDecoration ??
        BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        );
  }

  /// Calculates the offset for the dropdown based on alignment and screen space.
  Offset setOffset() {
    return Offset(
      widget.dropdownOffset?.dx ?? 0,
      displayOverlayBottom ? widget.dropdownOffset?.dy ?? 55 : -10,
    );
  }
}

/// A helper class to debounce pointer scroll events in the dropdown.
class SearchTimerMethod {
  /// The debounce duration in milliseconds.
  final int milliseconds;

  /// The action to execute after the debounce duration.
  late VoidCallback action;

  /// Timer used to manage the debounce.
  Timer? timer;

  /// Creates a [SearchTimerMethod] with the given debounce [milliseconds].
  SearchTimerMethod({required this.milliseconds});

  /// Runs the given [action] after the debounce duration.
  void run(VoidCallback action) {
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
