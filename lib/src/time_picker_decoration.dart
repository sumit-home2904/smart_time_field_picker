import 'package:flutter/material.dart';

/// Defines the overall decoration and styling for a [SmartTimeField].
///
/// Customize the appearance of the picker menu, text field, cursor, errors,
/// and dropdown elements using this class.
class TimePickerDecoration {
  /// Whether the text field is dense.
  bool? isDense;

  /// Whether the text field is enabled.
  bool? enabled;

  /// Whether the text field is filled with a background color.
  bool? filled;

  /// The label widget displayed above the text field.
  Widget? label;

  /// The error widget displayed when validation fails.
  Widget? error;

  /// The locale used for formatting, if any.
  Locale? locale;

  /// Whether to display the text cursor.
  bool? showCursor;

  /// The background fill color of the text field.
  Color? fillColor;

  /// An optional prefix icon displayed inside the text field.
  Widget? prefixIcon;

  /// Placeholder text displayed when the field is empty.
  String? hintText;

  /// The hover color of the text field.
  Color? hoverColor;

  /// The maximum number of lines the error text can occupy.
  int? errorMaxLines;

  /// The color of the text cursor.
  Color? cursorColor;

  /// Whether the text field is read-only.
  bool? fieldReadOnly;

  /// The width of the text cursor.
  double? cursorWidth;

  /// The style applied to the input text.
  TextStyle? textStyle;

  /// The style applied to the hint text.
  TextStyle? hintStyle;

  /// The style applied to error messages.
  TextStyle? errorStyle;

  /// The height of the text cursor.
  double? cursorHeight;

  /// The radius of the text cursor.
  Radius? cursorRadius;

  /// Offset to adjust the dropdown menu position.
  Offset? dropdownOffset;

  /// The color of the cursor when an error occurs.
  Color? cursorErrorColor;

  /// Padding around the list of items in the dropdown menu.
  EdgeInsets? listPadding;

  /// Border displayed when the text field shows an error.
  InputBorder? errorBorder;

  /// Border displayed when the text field is focused.
  InputBorder? focusedBorder;

  /// Border displayed when the text field is enabled.
  InputBorder? enabledBorder;

  /// Decoration applied to the dropdown menu container.
  BoxDecoration? menuDecoration;

  /// Text style used inside the dropdown menu items.
  PickerTextStyle? pickerTextStyle;

  /// Border radius of the dropdown menu.
  BorderRadiusGeometry? borderRadius;

  /// Decoration applied to suffix elements such as AM/PM buttons.
  SuffixDecoration? suffixDecoration;

  /// Padding applied inside the text field.
  EdgeInsetsGeometry? contentPadding;

  /// Constraints applied to suffix icons inside the text field.
  BoxConstraints? suffixIconConstraints;

  /// Creates a [TimePickerDecoration] with the given parameters.
  TimePickerDecoration({
    this.label,
    this.error,
    this.locale,
    this.filled,
    this.enabled,
    this.isDense,
    this.hintText,
    this.textStyle,
    this.fillColor,
    this.prefixIcon,
    this.hintStyle,
    this.hoverColor,
    this.errorStyle,
    this.showCursor,
    this.cursorWidth,
    this.cursorColor,
    this.listPadding,
    this.errorBorder,
    this.borderRadius,
    this.cursorHeight,
    this.cursorRadius,
    this.errorMaxLines,
    this.fieldReadOnly,
    this.enabledBorder,
    this.focusedBorder,
    this.dropdownOffset,
    this.contentPadding,
    this.pickerTextStyle,
    this.menuDecoration,
    this.suffixDecoration,
    this.cursorErrorColor,
    this.suffixIconConstraints,
  });

  /// Returns a copy of [TimePickerDecoration] with updated values.
  TimePickerDecoration.copyWith({
    bool? filled,
    bool? isDense,
    bool? enabled,
    Widget? error,
    Widget? label,
    Locale? locale,
    Color? fillColor,
    bool? showCursor,
    String? hintText,
    Color? hoverColor,
    Widget? prefixIcon,
    int? errorMaxLines,
    Color? cursorColor,
    double? cursorWidth,
    bool? fieldReadOnly,
    double? cursorHeight,
    TextStyle? textStyle,
    TextStyle? hintStyle,
    TextStyle? errorStyle,
    Radius? cursorRadius,
    Offset? dropdownOffset,
    EdgeInsets? listPadding,
    Color? cursorErrorColor,
    InputBorder? errorBorder,
    InputBorder? enabledBorder,
    InputBorder? focusedBorder,
    BoxDecoration? menuDecoration,
    PickerTextStyle? pickerTextStyle,
    EdgeInsetsGeometry? contentPadding,
    SuffixDecoration? suffixDecoration,
    BorderRadiusGeometry? borderRadius,
    BoxConstraints? suffixIconConstraints,
  }) {
    TimePickerDecoration(
      label: label ?? this.label,
      error: error ?? this.error,
      filled: filled ?? this.filled,
      locale: locale ?? this.locale,
      enabled: enabled ?? this.enabled,
      isDense: isDense ?? this.isDense,
      hintText: hintText ?? this.hintText,
      hintStyle: hintStyle ?? this.hintStyle,
      fillColor: fillColor ?? this.fillColor,
      textStyle: textStyle ?? this.textStyle,
      prefixIcon: prefixIcon ?? this.prefixIcon,
      errorStyle: errorStyle ?? this.errorStyle,
      hoverColor: hoverColor ?? this.hoverColor,
      showCursor: showCursor ?? this.showCursor,
      errorBorder: errorBorder ?? this.errorBorder,
      cursorColor: cursorColor ?? this.cursorColor,
      cursorWidth: cursorWidth ?? this.cursorWidth,
      listPadding: listPadding ?? this.listPadding,
      borderRadius: borderRadius ?? this.borderRadius,
      cursorHeight: cursorHeight ?? this.cursorHeight,
      cursorRadius: cursorRadius ?? this.cursorRadius,
      fieldReadOnly: fieldReadOnly ?? this.fieldReadOnly,
      enabledBorder: enabledBorder ?? this.enabledBorder,
      errorMaxLines: errorMaxLines ?? this.errorMaxLines,
      focusedBorder: focusedBorder ?? this.focusedBorder,
      dropdownOffset: dropdownOffset ?? this.dropdownOffset,
      contentPadding: contentPadding ?? this.contentPadding,
      menuDecoration: menuDecoration ?? this.menuDecoration,
      pickerTextStyle: pickerTextStyle ?? this.pickerTextStyle,
      suffixDecoration: suffixDecoration ?? this.suffixDecoration,
      cursorErrorColor: cursorErrorColor ?? this.cursorErrorColor,
      suffixIconConstraints:
          suffixIconConstraints ?? this.suffixIconConstraints,
    );
  }
}

/// Defines the decoration for suffix elements such as AM/PM toggles.
///
/// Used inside [TimePickerDecoration].
class SuffixDecoration {
  /// Text style for the suffix labels.
  TextStyle? textStyle;

  /// Height of the suffix widget.
  double? height;

  /// Width of the suffix widget.
  double? width;

  /// Decoration when the suffix is not selected.
  BoxDecoration? unSelectedDecoration;

  /// Decoration when the suffix is selected.
  BoxDecoration? selectedDecoration;

  /// Padding inside the suffix widget.
  EdgeInsetsGeometry? padding;

  /// Alignment of the content inside the suffix widget.
  AlignmentGeometry? alignment;

  /// Creates a [SuffixDecoration].
  SuffixDecoration({
    this.width,
    this.height,
    this.padding,
    this.textStyle,
    this.alignment,
    this.selectedDecoration,
    this.unSelectedDecoration,
  });

  /// Returns a copy of [SuffixDecoration] with updated values.
  SuffixDecoration.copyWith({
    TextStyle? textStyle,
    double? height,
    width,
    EdgeInsetsGeometry? padding,
    AlignmentGeometry? alignment,
    BoxDecoration? selectedDecoration,
    BoxDecoration? unSelectedDecoration,
  }) {
    SuffixDecoration(
      width: width ?? this.width,
      height: height ?? this.height,
      padding: padding ?? this.padding,
      alignment: alignment ?? this.alignment,
      textStyle: textStyle ?? this.textStyle,
      selectedDecoration: selectedDecoration ?? this.selectedDecoration,
      unSelectedDecoration: unSelectedDecoration ?? this.unSelectedDecoration,
    );
  }
}

/// A text style used inside the dropdown menu of [SmartTimeField].
///
/// Supports customization for size, weight, color, and alignment.
class PickerTextStyle {
  /// The color of the text.
  final Color? color;

  /// The maximum number of lines for the text.
  final int? maxLines;

  /// The height of each line of text.
  final double? height;

  /// The font size of the text.
  final double? fontSize;

  /// The color when the text is hovered.
  final Color? hoverColor;

  /// The font family used for the text.
  final String? fontFamily;

  /// The style of the font (normal, italic, etc.).
  final FontStyle? fontStyle;

  /// The alignment of the text.
  final TextAlign? textAlign;

  /// The spacing between letters.
  final double? letterSpacing;

  /// How overflowing text is handled.
  final TextOverflow? overflow;

  /// The thickness of the font.
  final FontWeight? fontWeight;

  /// The baseline alignment of the text.
  final TextBaseline? textBaseline;

  /// The direction of the text.
  final TextDirection? textDirection;

  /// Creates a [PickerTextStyle] with the given properties.
  const PickerTextStyle({
    this.color,
    this.height,
    this.maxLines,
    this.fontSize,
    this.overflow,
    this.textAlign,
    this.fontStyle,
    this.hoverColor,
    this.fontWeight,
    this.fontFamily,
    this.textBaseline,
    this.letterSpacing,
    this.textDirection,
  });

  /// Returns a copy of [PickerTextStyle] with updated values.
  PickerTextStyle copyWith({
    Color? color,
    int? maxLines,
    double? height,
    double? fontSize,
    Color? hoverColor,
    String? fontFamily,
    FontStyle? fontStyle,
    TextAlign? textAlign,
    double? letterSpacing,
    FontWeight? fontWeight,
    TextOverflow? overflow,
    TextBaseline? textBaseline,
    TextDirection? textDirection,
  }) {
    return PickerTextStyle(
      color: color ?? this.color,
      height: height ?? this.height,
      overflow: overflow ?? this.overflow,
      maxLines: maxLines ?? this.maxLines,
      fontSize: fontSize ?? this.fontSize,
      fontStyle: fontStyle ?? this.fontStyle,
      textAlign: textAlign ?? this.textAlign,
      fontWeight: fontWeight ?? this.fontWeight,
      hoverColor: hoverColor ?? this.hoverColor,
      fontFamily: fontFamily ?? this.fontFamily,
      textBaseline: textBaseline ?? this.textBaseline,
      textDirection: textDirection ?? this.textDirection,
      letterSpacing: letterSpacing ?? this.letterSpacing,
    );
  }
}
