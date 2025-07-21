export 'time_picker_decoration.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_time_field_picker/src/overlay_builder.dart';
import 'package:smart_time_field_picker/smart_time_field_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SmartTimeField extends StatefulWidget {
  /// when you have text fields, users can usually long-press to select text,
  /// which brings up the toolbar with options like copy, paste, etc. So,
  /// [enableInteractiveSelection] probably relates to enabling or disabling that behavior.
  final bool? enableInteractiveSelection;

  /// Use this for [FromFieldDropDown] to read only from the dropdown you want.
  final bool readOnly;

  /// get your open drop-down menu height it's have default 150 height
  final double? menuHeight;
  final double? menuWidth;

  /// the automatically generated controller an initial value.
  final String? initialItem;

  /// you can give your custom error text for 24Hour type Selected
  final String? errorFor24Hour;

  /// you can give your custom error text for 12Hour type Selected
  final String? errorFor12Hour;

  /// Use this to style your search or selected text.
  final TextStyle textStyle;

  /// Call when we need to focus; your drop-down is searchable.
  final FocusNode? focusNode;

  final TimePickerDecoration? timePickerDecoration;

  /// Callback function when an item is selected.
  final Function(String? value) onChanged;

  /// Enable the validation listener on item change.
  /// This implies to [validator] everytime when the item change.
  final AutovalidateMode? autoValidateMode;

  /// Use the [OverlayPortalController] to display or conceal your drop-down.
  final OverlayPortalController controller;

  /// call when you need to change the search field textAlign [TextAlign.start]
  final TextAlign textAlign;

  final double? elevation;

  final bool user12Hr;

  const SmartTimeField({
    super.key,
    this.focusNode,
    this.menuWidth,
    this.menuHeight,
    this.initialItem,
    this.elevation = 0,
    this.errorFor12Hour,
    this.errorFor24Hour,
    this.readOnly = false,
    this.user12Hr = false,
    this.autoValidateMode,
    required this.textStyle,
    required this.onChanged,
    required this.controller,
    this.timePickerDecoration,
    this.enableInteractiveSelection,
    this.textAlign = TextAlign.start,
  }) : assert(
          errorFor12Hour == null || errorFor24Hour == null,
          'You can only provide either errorFor12Hour or errorFor24Hour, not both.',
        );

  @override
  State<SmartTimeField> createState() => SmartTimeFieldState();
}

class SmartTimeFieldState extends State<SmartTimeField> {
  String? selectedItem;
  late List<String> items;

  int focusedIndex = -1;

  bool isAmSelected = true;
  bool isTypingDisabled = false;
  bool isKeyboardNavigation = false;

  final layerLink = LayerLink();
  final GlobalKey textFieldKey = GlobalKey();
  final GlobalKey itemListKey = GlobalKey();

  final ScrollController scrollController = ScrollController();
  final TextEditingController textController = TextEditingController();

  void changeFocusIndex(int index) {
    focusedIndex = index;
    setState(() {});
  }

  void changeKeyBool(bool newValue) {
    isKeyboardNavigation = newValue;
    setState(() {});
  }

  List<String> timeSlots = [
    "00:00",
    "00:30",
    "01:00",
    "01:30",
    "02:00",
    "02:30",
    "03:00",
    "03:30",
    "04:00",
    "04:30",
    "05:00",
    "05:30",
    "06:00",
    "06:30",
    "07:00",
    "07:30",
    "08:00",
    "08:30",
    "09:00",
    "09:30",
    "10:00",
    "10:30",
    "11:00",
    "11:30",
    "12:00",
    "12:30",
    "13:00",
    "13:30",
    "14:00",
    "14:30",
    "15:00",
    "15:30",
    "16:00",
    "16:30",
    "17:00",
    "17:30",
    "18:00",
    "18:30",
    "19:00",
    "19:30",
    "20:00",
    "20:30",
    "21:00",
    "21:30",
    "22:00",
    "22:30",
    "23:00",
    "23:30"
  ];

  List<String> timeSlots12HrUnique = [
    "12:00",
    "12:30",
    "01:00",
    "01:30",
    "02:00",
    "02:30",
    "03:00",
    "03:30",
    "04:00",
    "04:30",
    "05:00",
    "05:30",
    "06:00",
    "06:30",
    "07:00",
    "07:30",
    "08:00",
    "08:30",
    "09:00",
    "09:30",
    "10:00",
    "10:30",
    "11:00",
    "11:30"
  ];

  // — make this a member so it lives across rebuilds —
  late final MaskTextInputFormatter _maskFormatter;

  @override
  void initState() {
    super.initState();

    _maskFormatter = MaskTextInputFormatter(
      mask: '##:##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );
    // _limitFormatter = TimeLimitFormatter(widget.user12Hr);

    items = [];

    if (widget.focusNode != null) {
      widget.focusNode!.addListener(() async {
        if (widget.focusNode!.hasFocus) {
          if (widget.controller.isShowing) {
            focusedIndex = 0;
          } else {
            focusedIndex = -1;
          }
        } else {
          textController.text = widget.initialItem ?? "";
        }
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      items = !widget.user12Hr ? [...timeSlots] : [...timeSlots12HrUnique];
      textController.text = widget.initialItem ?? "";
      selectedItem = widget.initialItem;
    });
  }

  @override
  void didUpdateWidget(covariant SmartTimeField oldWidget) {
    super.didUpdateWidget(oldWidget);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialItem != oldWidget.initialItem) {
        if (widget.initialItem == null) {
          selectedItem = null;
          textController.clear();
        } else {
          selectedItem = widget.initialItem;
          textController.text = widget.initialItem ?? "";
        }
      }

      if (widget.user12Hr != oldWidget.user12Hr) {
        items = !widget.user12Hr ? [...timeSlots] : [...timeSlots12HrUnique];
      }
      setState(() {});
    });
  }

  void scrollToFocusedItem() {
    RenderBox? renderBox =
        itemListKey.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox == null) return;

    final double itemHeight = renderBox.size.height;

    final int maxVisibleItems = ((widget.menuHeight ?? 150) / itemHeight)
        .floor(); // How many items fit in the view
    final double firstVisibleIndex = scrollController.offset / itemHeight;
    final double lastVisibleIndex = firstVisibleIndex + (maxVisibleItems - 1);

    // Scroll down logic
    if (focusedIndex > lastVisibleIndex) {
      if (focusedIndex == items.length - 1) {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 70),
            curve: Curves.easeInOut,
          );
        }
      } else {
        scrollController.jumpTo(
          (focusedIndex - (maxVisibleItems - 1)) * itemHeight,
        );
      }
    }

    // Scroll up logic (only scroll when reaching firstVisibleIndex)
    else if (focusedIndex < firstVisibleIndex) {
      if (focusedIndex >= lastVisibleIndex - (maxVisibleItems - 1)) {
        // Do NOT scroll yet, allow selection to move up first
        return;
      }
      scrollController.jumpTo(
        focusedIndex * itemHeight,
      );
    }
  }

  /// This method is called when the user selects a drop-down value item from the list
  void onItemSelected({int? index}) {
    widget.controller.hide();

    if ((items.isNotEmpty &&
            focusedIndex >= 0 &&
            focusedIndex < items.length) ||
        index != null) {
      selectedItem = items[index ?? focusedIndex];

      textController.value = TextEditingValue(
        text: (selectedItem ?? ""),
        selection: TextSelection.collapsed(
          offset: (selectedItem ?? "").length,
        ),
      );

      onChangeAccordingTimeFormat(textController.text);
    } else {
      onChangeAccordingTimeFormat(textController.text);
    }

    focusedIndex = -1;
    setState(() {});
  }

  onChangeAccordingTimeFormat(String passingValue) {
    widget.onChanged(passingValue);
    FocusScope.of(context).unfocus();
  }

  final GlobalKey contentKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (widget.controller.isShowing) {
          widget.controller.hide();
        }
      },
      child: CallbackShortcuts(
        bindings: {
          LogicalKeySet(LogicalKeyboardKey.arrowUp): () {
            setState(() {
              isKeyboardNavigation = true;
              if (focusedIndex > 0) {
                focusedIndex--;
                scrollToFocusedItem();
              } else {
                focusedIndex = (items.length - 1);
                scrollToFocusedItem();
              }
            });
          },
          LogicalKeySet(LogicalKeyboardKey.arrowDown): () {
            dropDownOpen();
            setState(() {
              isKeyboardNavigation = true;
              if (focusedIndex < items.length - 1) {
                focusedIndex++;
                scrollToFocusedItem();
              } else {
                focusedIndex = 0;
                RenderBox? renderBox = itemListKey.currentContext
                    ?.findRenderObject() as RenderBox?;
                scrollController.jumpTo(
                  focusedIndex *
                      renderBox!.size.height, // Adjust height per item
                );
              }
            });
          },
          LogicalKeySet(LogicalKeyboardKey.enter): () {
            if (!widget.readOnly) {
              onItemSelected();
            }
          },
        },
        child: OverlayPortal(
          controller: widget.controller,
          overlayChildBuilder: (context) {
            final RenderBox? renderBox =
                textFieldKey.currentContext?.findRenderObject() as RenderBox?;

            return GestureDetector(
              onTap: () {
                onChangeAccordingTimeFormat(textController.text);
                widget.controller.hide();
              },
              child: Container(
                color: Colors.transparent,
                child: Stack(
                  children: [
                    OverlayBuilder(
                      item: items,
                      key: contentKey,
                      layerLink: layerLink,
                      renderBox: renderBox,
                      itemListKey: itemListKey,
                      focusedIndex: focusedIndex,
                      onChanged: widget.onChanged,
                      elevation: widget.elevation,
                      textStyle: widget.textStyle,
                      menuWidth: widget.menuWidth,
                      changeKeyBool: changeKeyBool,
                      controller: widget.controller,
                      changeIndex: changeFocusIndex,
                      menuHeight: widget.menuHeight,
                      initialItem: widget.initialItem,
                      scrollController: scrollController,
                      isKeyboardNavigation: isKeyboardNavigation,
                      timePickerDecoration: widget.timePickerDecoration,
                      listPadding: widget.timePickerDecoration?.listPadding,
                      onItemSelected: (value) => onItemSelected(index: value),
                      cursorRadius: widget.timePickerDecoration?.cursorRadius,
                      dropdownOffset:
                          widget.timePickerDecoration?.dropdownOffset,
                      fieldReadOnly:
                          widget.timePickerDecoration?.fieldReadOnly ?? false,
                    )
                  ],
                ),
              ),
            );
          },
          child: CompositedTransformTarget(
            link: layerLink,
            child: Listener(
                onPointerDown: (PointerDownEvent event) {
                  if (event.buttons == kSecondaryMouseButton) {
                    // Disable typing on secondary mouse button press
                    setState(() {
                      isTypingDisabled = true;
                    });
                  } else {
                    setState(() {
                      isTypingDisabled = false;
                    });
                  }
                },
                child: TextFormField(
                  key: textFieldKey,
                  style: widget.textStyle,
                  enableInteractiveSelection: widget
                          .enableInteractiveSelection ??
                      (!(widget.timePickerDecoration?.fieldReadOnly ?? false)),
                  keyboardType: TextInputType.number,
                  inputFormatters: [_maskFormatter],
                  textAlign: widget.textAlign,
                  readOnly: isTypingDisabled
                      ? true
                      : widget.timePickerDecoration?.fieldReadOnly ?? false,
                  focusNode: widget.focusNode,
                  controller: textController,
                  showCursor: widget.timePickerDecoration?.showCursor,
                  cursorHeight: widget.timePickerDecoration?.cursorHeight,
                  cursorWidth: widget.timePickerDecoration?.cursorWidth ?? 2.0,
                  cursorRadius: widget.timePickerDecoration?.cursorRadius,
                  decoration: InputDecoration(
                    error: widget.timePickerDecoration?.error,
                    label: widget.timePickerDecoration?.label,
                    filled: widget.timePickerDecoration?.filled,
                    hintText: widget.timePickerDecoration?.hintText,
                    hintStyle: widget.timePickerDecoration?.hintStyle,
                    fillColor: widget.timePickerDecoration?.fillColor,
                    prefixIcon: widget.timePickerDecoration?.prefixIcon,
                    errorStyle: widget.timePickerDecoration?.errorStyle,
                    enabled: widget.timePickerDecoration?.enabled ?? true,
                    isDense: widget.timePickerDecoration?.isDense ?? true,
                    errorBorder: widget.timePickerDecoration?.errorBorder,
                    errorMaxLines: widget.timePickerDecoration?.errorMaxLines,
                    focusedBorder: widget.timePickerDecoration?.focusedBorder ??
                        OutlineInputBorder(),
                    enabledBorder: widget.timePickerDecoration?.enabledBorder ??
                        OutlineInputBorder(),
                    contentPadding:
                        widget.timePickerDecoration?.contentPadding ??
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    suffixIcon: !widget.user12Hr
                        ? SizedBox()
                        : IntrinsicWidth(
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (!widget.readOnly) {
                                      setState(() {
                                        isAmSelected = true;
                                        onItemSelected();
                                      });
                                    }
                                  },
                                  child: Container(
                                      width: widget.timePickerDecoration
                                          ?.suffixDecoration?.width,
                                      height: widget.timePickerDecoration
                                          ?.suffixDecoration?.height,
                                      alignment: widget.timePickerDecoration
                                          ?.suffixDecoration?.alignment,
                                      padding: widget.timePickerDecoration
                                              ?.suffixDecoration?.padding ??
                                          EdgeInsets.all(08),
                                      decoration: amDecoration(isAmSelected),
                                      child: Text("AM",
                                          style: widget.timePickerDecoration
                                              ?.suffixDecoration?.textStyle)),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (!widget.readOnly) {
                                      setState(() {
                                        isAmSelected = false;
                                        onItemSelected();
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: widget.timePickerDecoration
                                        ?.suffixDecoration?.width,
                                    height: widget.timePickerDecoration
                                        ?.suffixDecoration?.height,
                                    alignment: widget.timePickerDecoration
                                        ?.suffixDecoration?.alignment,
                                    padding: widget.timePickerDecoration
                                            ?.suffixDecoration?.padding ??
                                        EdgeInsets.all(08),
                                    decoration: pmDecoration(!isAmSelected),
                                    child: Text("PM",
                                        style: widget.timePickerDecoration
                                            ?.suffixDecoration?.textStyle),
                                  ),
                                ),
                                SizedBox(width: 02)
                              ],
                            ),
                          ),
                    suffixIconConstraints:
                        widget.timePickerDecoration?.suffixIconConstraints,
                  ),
                  cursorColor:
                      widget.timePickerDecoration?.cursorColor ?? Colors.black,
                  cursorErrorColor:
                      widget.timePickerDecoration?.cursorErrorColor ??
                          Colors.black,
                  autovalidateMode: widget.autoValidateMode,
                  validator: _timeValidator,
                  onChanged: onChange,
                  onTap: textFiledOnTap,
                )),
          ),
        ),
      ),
    );
  }

  /// drop-down on tap function
  textFiledOnTap() async {
    focusedIndex = 0;
    // textController.selection = TextSelection(
    //   baseOffset: 0,
    //   extentOffset: textController.text.length,
    // );

    if (!(widget.readOnly)) {
      widget.controller.show();
      if (!widget.user12Hr) {
        items.addAll(timeSlots);
      } else {
        items.addAll(timeSlots12HrUnique);
      }
      setState(() {});
    }
  }

  /// drop-down search or text form filed on change function
  onChange(value) async {
    dropDownOpen();
    RenderBox? renderBox =
        itemListKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      focusedIndex = 0;
      scrollController.jumpTo(
        focusedIndex * renderBox.size.height, // Adjust height per item
      );
    }

    onSearchCalled(value);
  }

  /// when on search is not null then call this function
  void onSearchCalled(String value) {
    items = !widget.user12Hr ? [...timeSlots] : [...timeSlots12HrUnique];

    // normalize leading zeros away if you like:
    final search = value.replaceAll(RegExp(r'^0+'), '').toLowerCase();

    // find in the unfiltered _fullSource
    final matchIndex = items.indexWhere((element) {
      final normalizedElt =
          element.replaceAll(RegExp(r'^0+'), '').toLowerCase();
      return normalizedElt.startsWith(search);
    });

    if (matchIndex != -1) {
      focusedIndex = matchIndex;
      // scroll to that position
      scrollToFocusedItem();
      // and rebuild to show your highlight

      // textController.text = value;
      setState(() {});
    } else {
      focusedIndex = -1;
    }
    // if no match, you can leave focusedIndex alone or set it to -1
  }

  BoxDecoration amDecoration(isSelected) {
    if (isSelected) {
      return widget
              .timePickerDecoration?.suffixDecoration?.selectedDecoration ??
          BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                bottomLeft: Radius.circular(4),
              ));
    } else {
      return widget
              .timePickerDecoration?.suffixDecoration?.unSelectedDecoration ??
          BoxDecoration(color: Colors.transparent);
    }
  }

  BoxDecoration pmDecoration(isSelected) {
    if (isSelected) {
      return widget
              .timePickerDecoration?.suffixDecoration?.selectedDecoration ??
          BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ));
    } else {
      return widget
              .timePickerDecoration?.suffixDecoration?.unSelectedDecoration ??
          BoxDecoration(color: Colors.transparent);
    }
  }

  ///open drop down when any event trigger.
  dropDownOpen() {
    if (!widget.controller.isShowing) {
      focusedIndex = 0;
      widget.controller.show();
    }
  }

  String? _timeValidator(String? val) {
    if (val == null || val.isEmpty) return null;
    final parts = val.split(':');
    final hh = int.tryParse(parts[0].padLeft(2, '0')) ?? 0;
    final mm =
        parts.length > 1 ? (int.tryParse(parts[1].padLeft(2, '0')) ?? 0) : 0;
    final maxHour = widget.user12Hr ? 12 : 23;
    if (hh > maxHour || mm > 59) {
      return widget.user12Hr
          ? widget.errorFor12Hour ?? 'Must be ≤ 12:59'
          : widget.errorFor24Hour ?? 'Must be ≤ 23:59';
    }
    return null;
  }
}
