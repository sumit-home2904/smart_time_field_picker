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

  /// An icon that appears after the editable part of the text field and
  /// after the [suffix] or [suffixText], within the decoration's container.
  ///
  /// The size and color of the suffix icon is configured automatically using an
  /// [IconTheme] and therefore does not need to be explicitly given in the
  /// icon widget.
  ///
  /// The suffix icon is constrained with a minimum size of 48px by 48px, but
  /// can be expanded beyond that. Anything larger than 24px will require
  /// additional padding to ensure it matches the Material Design spec of 12px
  /// padding between the right edge of the input and trailing edge of the
  /// prefix icon. The following snippet shows how to pad the trailing edge of
  /// the suffix icon:
  ///
  /// ```dart
  /// suffixIcon: Padding(
  ///   padding: const EdgeInsetsDirectional.only(end: 12.0),
  ///   child: _myIcon, // myIcon is a 48px-wide widget.
  /// )
  /// ```
  ///
  /// The decoration's container is the area which is filled if [filled] is
  /// true and bordered per the [border]. It's the area adjacent to
  /// [icon] and above the widgets that contain [helperText],
  /// [errorText], and [counterText].
  ///
  /// The suffix icon alignment can be changed using [Align] with a fixed `widthFactor` and
  /// `heightFactor`.
  ///
  /// {@tool dartpad}
  /// This example shows how the suffix icon alignment can be changed using [Align] with
  /// a fixed `widthFactor` and `heightFactor`.
  ///
  /// ** See code in examples/api/lib/material/input_decorator/input_decoration.suffix_icon.0.dart **
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///  * [Icon] and [ImageIcon], which are typically used to show icons.
  ///  * [suffix] and [suffixText], which are other ways to show content
  ///    after the text field (but before the icon).
  ///  * [prefixIcon], which is the same but on the leading edge.
  ///  * [Align] A widget that aligns its child within itself and optionally
  ///    sizes itself based on the child's size.
  Widget? suffixIcon;

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
    this.suffixIcon,
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
    Widget? suffixIcon,
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
      locale: locale ?? this.locale,
      filled: filled ?? this.filled,
      isDense: isDense ?? this.isDense,
      enabled: enabled ?? this.enabled,
      hintText: hintText ?? this.hintText,
      fillColor: fillColor ?? this.fillColor,
      textStyle: textStyle ?? this.textStyle,
      hintStyle: hintStyle ?? this.hintStyle,
      prefixIcon: prefixIcon ?? this.prefixIcon,
      errorStyle: errorStyle ?? this.errorStyle,
      hoverColor: hoverColor ?? this.hoverColor,
      suffixIcon: suffixIcon ?? this.suffixIcon,
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
