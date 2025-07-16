import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:text_field_time_picker/src/signatures.dart';

import 'animated_section.dart';
import 'time_picker_decoration.dart';

class OverlayBuilder<T> extends StatefulWidget {
  final List<T> item;
  final T? initialItem;
  final int focusedIndex;
  final double? elevation;
  final bool fieldReadOnly;
  final LayerLink layerLink;
  final TextStyle textStyle;
  final Radius? cursorRadius;
  final RenderBox? renderBox;
  final double? overlayHeight;
  final GlobalKey itemListKey;
  final Offset? dropdownOffset;
  final EdgeInsets? listPadding;
  final Function(int) changeIndex;
  final bool isKeyboardNavigation;
  final Function(int) onItemSelected;
  final Function(T? value) onChanged;
  final Function(bool) changeKeyBool;
  // final BoxDecoration? menuDecoration;
  final TimePickerDecoration? timePickerDecoration;
  final ScrollController scrollController;
  final OverlayPortalController controller;
  final ListItemBuilder<T> listItemBuilder;

  const OverlayBuilder({
    super.key,
    this.renderBox,
    this.listPadding,
    this.initialItem,
    this.cursorRadius,
    this.elevation = 0,
    required this.item,
    this.overlayHeight,
    this.timePickerDecoration,
    this.dropdownOffset,
    required this.textStyle,
    required this.layerLink,
    required this.onChanged,
    required this.controller,
    required this.itemListKey,
    required this.changeIndex,
    required this.focusedIndex,
    this.fieldReadOnly = false,
    required this.changeKeyBool,
    required this.onItemSelected,
    required this.listItemBuilder,
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
  final key1 = GlobalKey(),
      key2 = GlobalKey();

  /// calculate drop-down height base on item length
  double baseOnHeightCalculate() {
    try {
      // final context = widget.addButtonKey.currentContext;
      final itemKeyContext = widget.itemListKey.currentContext;

      double itemHeight = 40; // Default height

      // Calculate item height
      if (itemKeyContext != null) {
        final renderBox = itemKeyContext.findRenderObject() as RenderBox?;
        itemHeight = renderBox?.size.height ?? 40; // Default to 40
      }

      else if (widget.item.isNotEmpty) {
        return widget.item.length * itemHeight + 10;
      }
      return 125;
    } catch (_) {
      return  125;
    }
  }

  /// The height of the drop-down container is calculated based on the item length or
  /// the add button, and when no items are available, the default pass height is displayed.
  double calculateHeight() {
    const double staticHeight = 150.0; // Static value fallback
    final double calculatedHeight = baseOnHeightCalculate();

    // If widget.overlayHeight is not provided, use staticHeight
    final double maxHeight = widget.overlayHeight ?? staticHeight;

    // Return the smaller value between the calculated height and maxHeight
    return calculatedHeight > maxHeight ? maxHeight : calculatedHeight;
  }

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

  /// use for move up and down when not scroll available
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
          // print("screenHeight $screenHeight");
          // print("y $y");
          // print("MediaQuery.of(context).viewInsets.bottom ${keyBoardHeight}");
          // print("render2.size.height ${render2.size.height}");
          // print(
          //     "calculation ${screenHeight - y - MediaQuery.of(context).viewInsets.bottom}");
          if (screenHeight - y - (MediaQuery.of(context).size.height * 0.4) < render2.size.height) {
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

    // Check if the item list or its length has changed
    if (oldWidget.item != widget.item ||
        oldWidget.item.length != widget.item.length) {
      // Trigger a recalculation and rebuild
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          baseOnHeightCalculate();
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
        child: LayoutBuilder(builder: (context, c) {
          return SizedBox(
            height: calculateHeight() + 4,
            width: widget.renderBox?.size.width ?? c.maxWidth,
            child: Card(
              elevation: widget.elevation,
              color: Colors.blue,
              margin: EdgeInsets.zero,
              child: Container(
                key: key1,
                height: calculateHeight() + 4,
                decoration: menuDecoration(),
                child: AnimatedSection(
                  expand: true,
                  animationDismissed: widget.controller.hide,
                  axisAlignment: displayOverlayBottom ? 1.0 : -1.0,
                  child: Container(
                      key: key2,
                      height: calculateHeight() + 4,
                      width: MediaQuery
                          .sizeOf(context)
                          .width,
                      child: uiListWidget()),
                ),
              ),
            ),
          );
        })
    );
  }

  /// This function returns the UI of drop-down tiles when the user clicks on
  /// the drop-down. After that, how the drop-down will look is all defined in
  /// this function.
  ///
  // bool isKeyboardNavigation = false;
  Widget uiListWidget() {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (notification) {
        notification.disallowIndicator();
        return true;
      },
      child: Container(
        height: calculateHeight(),
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
                    padding: widget.listPadding ?? EdgeInsets.symmetric(vertical: 4),
                    itemCount: widget.item.length,
                    itemBuilder: (_, index) {
                      bool selected = widget.focusedIndex == index;
                      // print(index);
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
                          child: widget.listItemBuilder(
                            context, widget.item[index], selected,
                          ),
                        ),
                      );
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }



  ///This is for the drop-down container decoration. If the user wants to provide
  /// a custom decoration, they can do so. However, if the widget is not set for
  /// the user side, we will provide our own default decoration.
  BoxDecoration menuDecoration() {
    return  widget.timePickerDecoration?.menuDecoration?? BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(5)
    );
  }

  Offset setOffset() {
    // print(Offset(widget.dropdownOffset?.dx ?? 0, displayOverlayBottom ? widget.dropdownOffset?.dy ?? 55 : -10));
    return Offset(widget.dropdownOffset?.dx ?? 0,
        displayOverlayBottom ? widget.dropdownOffset?.dy ?? 55 : -10);
  }

}

class SearchTimerMethod {
  final int milliseconds;
  late VoidCallback action;
  Timer? timer;

  SearchTimerMethod({required this.milliseconds});

  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
