library smart_time_field_picker;

export 'src/time_picker_decoration.dart';
import 'src/time_picker_decoration.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'src/overlay_builder.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SmartTimeFieldPicker extends StatefulWidget {
  /// Whether interactive text selection (copy, paste, etc.) is enabled.
  ///
  /// If `null`, it falls back to the `fieldReadOnly` flag in
  /// [TimePickerDecoration].
  final bool? enableInteractiveSelection;

  /// Whether the field is read-only and input is only allowed from the dropdown.
  final bool readOnly;

  /// Height of the dropdown menu when opened.
  ///
  /// Defaults to `150`.
  final double? menuHeight;

  /// Width of the dropdown menu when opened.
  final double? menuWidth;

  /// Initial value of the text field when first built.
  final String? initialItem;

  /// Text style for the main input field.
  final TextStyle textStyle;

  /// Focus node to control and listen for focus changes on the text field.
  final FocusNode? focusNode;

  /// Additional fieldDecoration properties for customizing the look of the field
  /// and dropdown menu.
  final TimePickerDecoration? timePickerDecoration;

  /// Callback function that is triggered when the value changes.
  final Function(String? value) onChanged;

  /// Specifies when the validator function should be called.
  ///
  /// Defaults to null.
  final AutovalidateMode? autoValidateMode;

  /// Controller for showing or hiding the dropdown overlay.
  final OverlayPortalController controller;

  /// Alignment of the input text.
  ///
  /// Defaults to [TextAlign.start].
  final TextAlign textAlign;

  /// Elevation of the dropdown menu card.
  ///
  /// Defaults to `0`.
  final double? elevation;

  /// Determines if the field uses 12-hour format.
  ///
  /// - `true`: 12-hour format (AM/PM toggle enabled)
  /// - `false`: 24-hour format
  final bool user12Hr;

  /// Validator function to check if the inputted time is valid.
  ///
  /// Returns an error message string if invalid or `null` if valid.
  final String? Function(String?)? validator;

  /// Creates a [SmartTimeFieldPicker] widget.

  const SmartTimeFieldPicker({
    super.key,
    this.validator,
    this.focusNode,
    this.menuWidth,
    this.menuHeight,
    this.initialItem,
    this.elevation = 0,
    this.readOnly = false,
    this.user12Hr = false,
    this.autoValidateMode,
    required this.textStyle,
    required this.onChanged,
    required this.controller,
    this.timePickerDecoration,
    this.enableInteractiveSelection,
    this.textAlign = TextAlign.start,
  });

  @override
  State<SmartTimeFieldPicker> createState() => SmartTimeFieldState();
}

class SmartTimeFieldState extends State<SmartTimeFieldPicker> {
  /// Currently selected time item.
  String? selectedItem;

  /// List of time items displayed in the dropdown menu.
  late List<String> items;

  /// Index of the currently focused item in the dropdown list.
  int focusedIndex = -1;

  /// Whether the "AM" toggle is selected (for 12-hour format).
  bool isAmSelected = true;

  /// Whether typing in the input field is disabled.
  bool isTypingDisabled = false;

  /// Whether navigation through the dropdown is being done using the keyboard.
  bool isKeyboardNavigation = false;

  /// Layer link used to position the dropdown overlay.
  final layerLink = LayerLink();

  /// Key for the main text field widget.
  final GlobalKey textFieldKey = GlobalKey();

  /// Key for the dropdown list widget.
  final GlobalKey itemListKey = GlobalKey();

  /// Scroll controller for the dropdown list.
  final ScrollController scrollController = ScrollController();

  /// Controller for the text input field.
  final TextEditingController textController = TextEditingController();

  /// Updates the focused index in the dropdown list.
  void changeFocusIndex(int index) {
    focusedIndex = index;
    setState(() {});
  }

  /// Updates the keyboard navigation flag.
  void changeKeyBool(bool newValue) {
    isKeyboardNavigation = newValue;
    setState(() {});
  }

  /// List of available time slots for 24-hour format.
  final List<String> timeSlots = [
    "00:00", "00:30", "01:00", "01:30", "02:00", "02:30", "03:00", "03:30", "04:00", "04:30",
    "05:00", "05:30", "06:00", "06:30", "07:00", "07:30", "08:00", "08:30", "09:00", "09:30",
    "10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30",
    "15:00", "15:30", "16:00", "16:30", "17:00", "17:30", "18:00", "18:30", "19:00", "19:30",
    "20:00", "20:30", "21:00", "21:30", "22:00", "22:30", "23:00", "23:30"
  ];

  /// List of available time slots for 12-hour format.
  final List<String> timeSlots12HrUnique = [
    "12:00", "12:30", "01:00", "01:30", "02:00", "02:30", "03:00", "03:30", "04:00", "04:30", "05:00",
    "05:30", "06:00", "06:30", "07:00", "07:30", "08:00", "08:30", "09:00", "09:30", "10:00", "10:30",
    "11:00",
    "11:30"
  ];

  /// Formatter for enforcing a `##:##` time input mask.
  late final MaskTextInputFormatter _maskFormatter;

  @override
  void initState() {
    super.initState();

    _maskFormatter = MaskTextInputFormatter(
      mask: '##:##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );

    if (widget.initialItem != null) {
      final value = widget.initialItem.toString().toUpperCase();
      if (value.contains('AM')) {
        isAmSelected = true;
      } else if (value.contains('PM')) {
        isAmSelected = false;
      }
    }

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
          // Remove AM/PM when losing focus
          final cleanText = widget.initialItem
              ?.replaceAll(RegExp(r'\s?(AM|PM)', caseSensitive: false), '') ?? '';
          textController.text = cleanText;
        }
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      items = !widget.user12Hr ? [...timeSlots] : [...timeSlots12HrUnique];

      // Remove AM/PM if present in initialItem
      final cleanText = widget.initialItem
          ?.replaceAll(RegExp(r'\s?(AM|PM)', caseSensitive: false), '');

      textController.text = cleanText ?? "";
      selectedItem = cleanText;
    });
  }


  @override
  void didUpdateWidget(covariant SmartTimeFieldPicker oldWidget) {
    super.didUpdateWidget(oldWidget);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialItem != oldWidget.initialItem) {
        if (widget.initialItem == null) {
          selectedItem = null;
          textController.clear();
        } else {
          selectedItem = widget.initialItem;

          // Check AM/PM and update isAmSelected
          final value = widget.initialItem!.toUpperCase();
          if (value.contains('AM')) {
            isAmSelected = true;
          } else if (value.contains('PM')) {
            isAmSelected = false;
          }

          // Remove AM/PM if present and update text
          final cleanText = widget.initialItem!
              .replaceAll(RegExp(r'\s?(AM|PM)', caseSensitive: false), '');
          textController.text = cleanText;
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
    widget.onChanged("$passingValue ${isAmSelected ? "AM" : "PM"}");
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
                    error: widget.timePickerDecoration?.fieldDecoration?.error,
                    label: widget.timePickerDecoration?.fieldDecoration?.label,
                    filled:
                        widget.timePickerDecoration?.fieldDecoration?.filled,
                    hintText:
                        widget.timePickerDecoration?.fieldDecoration?.hintText,
                    hintStyle:
                        widget.timePickerDecoration?.fieldDecoration?.hintStyle,
                    fillColor:
                        widget.timePickerDecoration?.fieldDecoration?.fillColor,
                    prefixIcon: widget
                        .timePickerDecoration?.fieldDecoration?.prefixIcon,
                    errorStyle: widget
                        .timePickerDecoration?.fieldDecoration?.errorStyle,
                    enabled:
                        widget.timePickerDecoration?.fieldDecoration?.enabled ??
                            true,
                    isDense:
                        widget.timePickerDecoration?.fieldDecoration?.isDense ??
                            true,
                    errorBorder: widget
                        .timePickerDecoration?.fieldDecoration?.errorBorder,
                    focusedErrorBorder: widget.timePickerDecoration
                        ?.fieldDecoration?.focusedErrorBorder,
                    focusColor: widget
                        .timePickerDecoration?.fieldDecoration?.focusColor,
                    errorMaxLines: widget
                        .timePickerDecoration?.fieldDecoration?.errorMaxLines,
                    focusedBorder: widget.timePickerDecoration?.fieldDecoration
                            ?.focusedBorder ??
                        OutlineInputBorder(),
                    enabledBorder: widget.timePickerDecoration?.fieldDecoration
                            ?.enabledBorder ??
                        OutlineInputBorder(),
                    contentPadding: widget.timePickerDecoration?.fieldDecoration
                            ?.contentPadding ??
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    suffixIcon: !widget.user12Hr
                        ? widget
                            .timePickerDecoration?.fieldDecoration?.suffixIcon
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
                                      child: Text(
                                          "AM",
                                          style: isAmSelected
                                              ?
                                          widget.timePickerDecoration?.suffixDecoration?.amSelectedDecoration?.textStyle
                                              :
                                          widget.timePickerDecoration?.suffixDecoration?.amUnSelectedDecoration?.textStyle
                                      )
                                  ),
                                ),
                                SizedBox(width: 2),
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
                                        style: isAmSelected
                                            ?
                                        widget.timePickerDecoration?.suffixDecoration?.pmSelectedDecoration?.textStyle
                                            :
                                        widget.timePickerDecoration?.suffixDecoration?.pmUnSelectedDecoration?.textStyle
                                    ),
                                  ),
                                ),
                                SizedBox(width: 02)
                              ],
                            ),
                          ),
                    suffixIconConstraints: widget.timePickerDecoration
                        ?.fieldDecoration?.suffixIconConstraints,
                  ),
                  cursorColor:
                      widget.timePickerDecoration?.cursorColor ?? Colors.black,
                  cursorErrorColor:
                      widget.timePickerDecoration?.cursorErrorColor ??
                          Colors.black,
                  autovalidateMode: widget.autoValidateMode,
                  validator: widget.validator ?? _timeValidator,
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
    if (!(widget.readOnly)) {
      widget.controller.show();
      items = !widget.user12Hr ? [...timeSlots] : [...timeSlots12HrUnique];
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
    // Restore all items first
    items = !widget.user12Hr ? [...timeSlots] : [...timeSlots12HrUnique];

    final search = value.replaceAll(RegExp(r'^0+'), '').toLowerCase();

    // Find index of first match
    final matchIndex = items.indexWhere((element) {
      final normalizedElt = element.replaceAll(RegExp(r'^0+'), '').toLowerCase();
      return normalizedElt.startsWith(search);
    });

    if (matchIndex != -1) {
      focusedIndex = matchIndex;
      scrollToFocusedItem();
      setState(() {}); // rebuild to highlight
    } else {
      focusedIndex = -1;
      setState(() {}); // also rebuild when no match
    }
  }


  BoxDecoration amDecoration(isSelected) {
    if (isSelected) {
      return
          BoxDecoration(
              color: widget.timePickerDecoration?.suffixDecoration?.amSelectedDecoration?.color ?? Colors.green,
              borderRadius: widget.timePickerDecoration?.suffixDecoration?.amSelectedDecoration?.borderRadius ?? BorderRadius.only(
                topLeft: Radius.circular(4),
                bottomLeft: Radius.circular(4),
              ),
              gradient:widget.timePickerDecoration?.suffixDecoration?.amSelectedDecoration?.gradient,
              backgroundBlendMode:widget.timePickerDecoration?.suffixDecoration?.amSelectedDecoration?.backgroundBlendMode,
              shape:widget.timePickerDecoration?.suffixDecoration?.amSelectedDecoration?.shape ?? BoxShape.rectangle,
          );
    } else {
      return  BoxDecoration(
        color: widget.timePickerDecoration?.suffixDecoration?.amUnSelectedDecoration?.color ?? Colors.transparent,
        borderRadius: widget.timePickerDecoration?.suffixDecoration?.amUnSelectedDecoration?.borderRadius,
        gradient:widget.timePickerDecoration?.suffixDecoration?.amUnSelectedDecoration?.gradient,
        backgroundBlendMode:widget.timePickerDecoration?.suffixDecoration?.amUnSelectedDecoration?.backgroundBlendMode,
        shape:widget.timePickerDecoration?.suffixDecoration?.amUnSelectedDecoration?.shape ?? BoxShape.rectangle,
      );
    }
  }

  BoxDecoration pmDecoration(isSelected) {
    if (isSelected) {
      return
        BoxDecoration(
          color: widget.timePickerDecoration?.suffixDecoration?.pmSelectedDecoration?.color ?? Colors.green,
          borderRadius: widget.timePickerDecoration?.suffixDecoration?.pmSelectedDecoration?.borderRadius ?? BorderRadius.only(
            topRight: Radius.circular(4),
            bottomRight: Radius.circular(4),
          ),
          gradient:widget.timePickerDecoration?.suffixDecoration?.pmSelectedDecoration?.gradient,
          backgroundBlendMode:widget.timePickerDecoration?.suffixDecoration?.pmSelectedDecoration?.backgroundBlendMode,
          shape:widget.timePickerDecoration?.suffixDecoration?.pmSelectedDecoration?.shape ?? BoxShape.rectangle,
        );
    } else {
      return  BoxDecoration(
        color: widget.timePickerDecoration?.suffixDecoration?.pmUnSelectedDecoration?.color ?? Colors.transparent,
        borderRadius: widget.timePickerDecoration?.suffixDecoration?.pmUnSelectedDecoration?.borderRadius,
        gradient:widget.timePickerDecoration?.suffixDecoration?.pmUnSelectedDecoration?.gradient,
        backgroundBlendMode:widget.timePickerDecoration?.suffixDecoration?.amUnSelectedDecoration?.backgroundBlendMode,
        shape:widget.timePickerDecoration?.suffixDecoration?.pmUnSelectedDecoration?.shape ?? BoxShape.rectangle,
      );
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
      return widget.user12Hr ? 'Must be ≤ 12:59' : 'Must be ≤ 23:59';
    }
    return null;
  }
}