import 'dart:async';
import 'dart:io';
import 'animated_section.dart';
import 'time_picker_decoration.dart';
import 'package:flutter/material.dart';

class OverlayBuilder<T> extends StatefulWidget {
  final List<T> item;
  final T? initialItem;
  final int focusedIndex;
  final double? menuWidth;
  final double? elevation;
  final double? menuHeight;
  final bool fieldReadOnly;
  final LayerLink layerLink;
  final TextStyle textStyle;
  final Radius? cursorRadius;
  final RenderBox? renderBox;
  final GlobalKey itemListKey;
  final Offset? dropdownOffset;
  final EdgeInsets? listPadding;
  final Function(int) changeIndex;
  final bool isKeyboardNavigation;
  final Function(T? value) onChanged;
  final Function(bool) changeKeyBool;
  final ScrollController scrollController;
  final OverlayPortalController controller;
  final Function(int? value) onItemSelected;
  final TimePickerDecoration? timePickerDecoration;

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
        child: LayoutBuilder(builder: (context, c) {
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
                      child: uiListWidget()),
                ),
              ),
            ),
          );
        }));
  }

  /// This function returns the UI of drop-down tiles when the user clicks on
  /// the drop-down. After that, how the drop-down will look is all defined in
  /// this function.
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
                    child:Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      margin: EdgeInsets.fromLTRB(5, 2, 5, 1),
                      decoration: BoxDecoration(
                        color: selected ? Colors.green : Colors.transparent,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        "${widget.item[index]}",
                        style: widget.timePickerDecoration?.textStyle?? TextStyle(
                          fontSize: 12,
                          color: selected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ),
                );
              },
            ),
          )),
        ],
      ),
    );
  }

  ///This is for the drop-down container decoration. If the user wants to provide
  /// a custom decoration, they can do so. However, if the widget is not set for
  /// the user side, we will provide our own default decoration.
  BoxDecoration menuDecoration() {
    return widget.timePickerDecoration?.menuDecoration ??
        BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(5));
  }

  Offset setOffset() {
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
