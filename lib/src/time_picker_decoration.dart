import 'package:flutter/material.dart';

/// Defines the overall fieldDecoration and styling for a [SmartTimeField].
///
/// Customize the appearance of the picker menu, text field, cursor, errors,
/// and dropdown elements using this class.
class TimePickerDecoration {
  /// The color of the text cursor.
  Color? cursorColor;
  FieldDecoration? fieldDecoration;

  /// Whether the text field is read-only.
  bool? fieldReadOnly;

  /// The width of the text cursor.
  double? cursorWidth;

  /// The style applied to the input text.
  TextStyle? textStyle;

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

  /// The hover color of the text field.
  Color? hoverColor;

  /// Decoration applied to the dropdown menu container.
  BoxDecoration? menuDecoration;

  /// Text style used inside the dropdown menu items.
  PickerTextStyle? pickerTextStyle;

  /// Border radius of the dropdown menu.
  BorderRadiusGeometry? borderRadius;

  /// Whether to display the text cursor.
  bool? showCursor;

  /// Decoration applied to suffix elements such as AM/PM buttons.
  SuffixDecoration? suffixDecoration;

  /// Creates a [TimePickerDecoration] with the given parameters.
  TimePickerDecoration(
      {this.textStyle,
      this.showCursor,
      this.hoverColor,
      this.cursorWidth,
      this.cursorColor,
      this.listPadding,
      this.borderRadius,
      this.cursorHeight,
      this.cursorRadius,
      this.fieldReadOnly,
      this.dropdownOffset,
      this.menuDecoration,
      this.pickerTextStyle,
      this.cursorErrorColor,
      this.suffixDecoration,
      this.fieldDecoration});

  /// Returns a copy of [TimePickerDecoration] with updated values.
  TimePickerDecoration copyWith({
    bool? showCursor,
    Color? hoverColor,
    Color? cursorColor,
    double? cursorWidth,
    bool? fieldReadOnly,
    double? cursorHeight,
    TextStyle? textStyle,
    Radius? cursorRadius,
    Offset? dropdownOffset,
    Color? cursorErrorColor,
    EdgeInsets? listPadding,
    BoxDecoration? menuDecoration,
    PickerTextStyle? pickerTextStyle,
    BorderRadiusGeometry? borderRadius,
    SuffixDecoration? suffixDecoration,
    FieldDecoration? fieldDecoration,
  }) {
    return TimePickerDecoration(
      showCursor: showCursor ?? this.showCursor,
      textStyle: textStyle ?? this.textStyle,
      hoverColor: hoverColor ?? this.hoverColor,
      cursorColor: cursorColor ?? this.cursorColor,
      cursorWidth: cursorWidth ?? this.cursorWidth,
      listPadding: listPadding ?? this.listPadding,
      borderRadius: borderRadius ?? this.borderRadius,
      cursorHeight: cursorHeight ?? this.cursorHeight,
      cursorRadius: cursorRadius ?? this.cursorRadius,
      fieldReadOnly: fieldReadOnly ?? this.fieldReadOnly,
      dropdownOffset: dropdownOffset ?? this.dropdownOffset,
      menuDecoration: menuDecoration ?? this.menuDecoration,
      pickerTextStyle: pickerTextStyle ?? this.pickerTextStyle,
      cursorErrorColor: cursorErrorColor ?? this.cursorErrorColor,
      suffixDecoration: suffixDecoration ?? this.suffixDecoration,
      fieldDecoration: fieldDecoration ?? this.fieldDecoration,
    );
  }
}

class FieldDecoration {
  /// Padding applied inside the text field.
  EdgeInsetsGeometry? contentPadding;

  /// Constraints applied to suffix icons inside the text field.
  BoxConstraints? suffixIconConstraints;

  /// Border displayed when the text field shows an error.
  InputBorder? errorBorder;

  /// Border displayed when the text field is focused and has an error.
  InputBorder? focusedErrorBorder;

  /// Border displayed when the text field is focused.
  InputBorder? focusedBorder;

  /// Border displayed when the text field is enabled.
  InputBorder? enabledBorder;

  /// The style applied to error messages.
  TextStyle? errorStyle;

  /// The style applied to the hint text.
  TextStyle? hintStyle;

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
  /// after the [suffix] or [suffixText], within the fieldDecoration's container.
  Widget? suffixIcon;

  /// The background fill color of the text field.
  Color? fillColor;

  /// An optional prefix icon displayed inside the text field.
  Widget? prefixIcon;

  /// Placeholder text displayed when the field is empty.
  String? hintText;

  /// Color used for focus highlights (e.g., when the field gains focus).
  Color? focusColor;

  /// The maximum number of lines the error text can occupy.
  int? errorMaxLines;

  FieldDecoration({
    this.label,
    this.error,
    this.filled,
    this.enabled,
    this.isDense,
    this.hintText,
    this.fillColor,
    this.prefixIcon,
    this.suffixIcon,
    this.hintStyle,
    this.focusColor,
    this.errorStyle,
    this.errorBorder,
    this.errorMaxLines,
    this.enabledBorder,
    this.focusedBorder,
    this.contentPadding,
    this.focusedErrorBorder,
    this.suffixIconConstraints,
  });

  FieldDecoration copyWith({
    bool? filled,
    bool? isDense,
    bool? enabled,
    Widget? error,
    Widget? label,
    Color? fillColor,
    String? hintText,
    Widget? suffixIcon,
    TextStyle? errorStyle,
    InputBorder? errorBorder,
    InputBorder? enabledBorder,
    InputBorder? focusedBorder,
    InputBorder? focusedErrorBorder,
    EdgeInsetsGeometry? contentPadding,
    BoxConstraints? suffixIconConstraints,
  }) {
    return FieldDecoration(
      label: label ?? this.label,
      error: error ?? this.error,
      filled: filled ?? this.filled,
      isDense: isDense ?? this.isDense,
      enabled: enabled ?? this.enabled,
      hintText: hintText ?? this.hintText,
      fillColor: fillColor ?? this.fillColor,
      errorStyle: errorStyle ?? this.errorStyle,
      suffixIcon: suffixIcon ?? this.suffixIcon,
      errorBorder: errorBorder ?? this.errorBorder,
      enabledBorder: enabledBorder ?? this.enabledBorder,
      focusedBorder: focusedBorder ?? this.focusedBorder,
      contentPadding: contentPadding ?? this.contentPadding,
      focusedErrorBorder: focusedErrorBorder ?? this.focusedErrorBorder,
      suffixIconConstraints:
          suffixIconConstraints ?? this.suffixIconConstraints,
    );
  }
}

/// Defines the fieldDecoration for suffix elements such as AM/PM toggles.
///
/// Used inside [TimePickerDecoration].
class SuffixDecoration {
  /// Height of the suffix widget.
  double? height;

  /// Width of the suffix widget.
  double? width;

  /// Decoration when the suffix is not selected.
  UnSelectedDecoration? amUnSelectedDecoration;

  /// Decoration when the suffix is selected.
  SelectedDecoration? amSelectedDecoration;

  /// Decoration when the suffix is not selected.
  UnSelectedDecoration? pmUnSelectedDecoration;

  /// Decoration when the suffix is selected.
  SelectedDecoration? pmSelectedDecoration;

  /// Padding inside the suffix widget.
  EdgeInsetsGeometry? padding;

  /// Alignment of the content inside the suffix widget.
  AlignmentGeometry? alignment;

  /// Creates a [SuffixDecoration].
  SuffixDecoration({
    this.width,
    this.height,
    this.padding,
    this.alignment,
    this.amSelectedDecoration,
    this.pmSelectedDecoration,
    this.amUnSelectedDecoration,
    this.pmUnSelectedDecoration,
  });

  /// Returns a copy of [SuffixDecoration] with updated values.
  SuffixDecoration copyWith({
    double? height,
    width,
    EdgeInsetsGeometry? padding,
    AlignmentGeometry? alignment,
    SelectedDecoration? amSelectedDecoration,
    SelectedDecoration? pmSelectedDecoration,
    UnSelectedDecoration? amUnSelectedDecoration,
    UnSelectedDecoration? pmUnSelectedDecoration,
  }) {
    return SuffixDecoration(
      width: width ?? this.width,
      height: height ?? this.height,
      padding: padding ?? this.padding,
      alignment: alignment ?? this.alignment,
      amSelectedDecoration: amSelectedDecoration ?? this.amSelectedDecoration,
      pmSelectedDecoration: amSelectedDecoration ?? this.pmSelectedDecoration,
      amUnSelectedDecoration:
          amUnSelectedDecoration ?? this.amUnSelectedDecoration,
      pmUnSelectedDecoration:
          amUnSelectedDecoration ?? this.pmUnSelectedDecoration,
    );
  }
}

/// Defines the visual styling for a selected suffix element, such as an AM/PM toggle.
///
/// Can customize color, shape, gradient, text styling, and background blend mode.
class SelectedDecoration {
  /// The background color of the selected element.
  final Color? color;

  /// The border radius applied to the element.
  final BorderRadiusGeometry? borderRadius;

  /// A gradient used to fill the background of the element.
  final Gradient? gradient;

  /// The blend mode used when applying the [gradient] or [color].
  final BlendMode? backgroundBlendMode;

  /// The shape of the element. Defaults to [BoxShape.rectangle].
  final BoxShape shape;

  /// The style applied to the text inside the selected element.
  final TextStyle? textStyle;

  /// Creates a [SelectedDecoration] with the given styling properties.
  const SelectedDecoration({
    this.color,
    this.borderRadius,
    this.gradient,
    this.backgroundBlendMode,
    this.shape = BoxShape.rectangle,
    this.textStyle,
  });

  /// Returns a copy of this [SelectedDecoration] with updated values.
  SelectedDecoration copyWith({
    Color? color,
    BorderRadiusGeometry? borderRadius,
    Gradient? gradient,
    BlendMode? backgroundBlendMode,
    BoxShape? shape,
    TextStyle? textStyle,
  }) {
    return SelectedDecoration(
      color: color ?? this.color,
      borderRadius: borderRadius ?? this.borderRadius,
      gradient: gradient ?? this.gradient,
      backgroundBlendMode: backgroundBlendMode ?? this.backgroundBlendMode,
      shape: shape ?? this.shape,
      textStyle: textStyle ?? this.textStyle,
    );
  }
}

/// Defines the visual styling for an unselected suffix element, such as an AM/PM toggle.
///
/// Can customize color, shape, gradient, text styling, and background blend mode.
class UnSelectedDecoration {
  /// The background color of the unselected element.
  final Color? color;

  /// The border radius applied to the element.
  final BorderRadiusGeometry? borderRadius;

  /// A gradient used to fill the background of the element.
  final Gradient? gradient;

  /// The blend mode used when applying the [gradient] or [color].
  final BlendMode? backgroundBlendMode;

  /// The shape of the element. Defaults to [BoxShape.rectangle].
  final BoxShape shape;

  /// The style applied to the text inside the unselected element.
  final TextStyle? textStyle;

  /// Creates an [UnSelectedDecoration] with the given styling properties.
  const UnSelectedDecoration({
    this.color,
    this.borderRadius,
    this.gradient,
    this.backgroundBlendMode,
    this.shape = BoxShape.rectangle,
    this.textStyle,
  });

  /// Returns a copy of this [UnSelectedDecoration] with updated values.
  UnSelectedDecoration copyWith({
    Color? color,
    BorderRadiusGeometry? borderRadius,
    Gradient? gradient,
    BlendMode? backgroundBlendMode,
    BoxShape? shape,
    TextStyle? textStyle,
  }) {
    return UnSelectedDecoration(
      color: color ?? this.color,
      borderRadius: borderRadius ?? this.borderRadius,
      gradient: gradient ?? this.gradient,
      backgroundBlendMode: backgroundBlendMode ?? this.backgroundBlendMode,
      shape: shape ?? this.shape,
      textStyle: textStyle ?? this.textStyle,
    );
  }
}

/// Defines the text styling used inside the dropdown menu of [SmartTimeField].
///
/// Supports customization of font size, weight, color, alignment, letter spacing,
/// and text overflow.
class PickerTextStyle {
  /// The locale used for text formatting, if any.
  final Locale? locale;

  /// The color of the text.
  final Color? color;

  /// The maximum number of lines for the text.
  final int? maxLines;

  /// The height of each line of text.
  final double? height;

  /// The font size of the text.
  final double? fontSize;

  /// The color of the text when hovered.
  final Color? hoverColor;

  /// The font family used for the text.
  final String? fontFamily;

  /// The style of the font (e.g., normal, italic).
  final FontStyle? fontStyle;

  /// The alignment of the text.
  final TextAlign? textAlign;

  /// The spacing between letters.
  final double? letterSpacing;

  /// How overflowing text is handled (e.g., ellipsis, clip).
  final TextOverflow? overflow;

  /// The thickness of the font.
  final FontWeight? fontWeight;

  /// The baseline alignment of the text.
  final TextBaseline? textBaseline;

  /// The text direction (e.g., left-to-right, right-to-left).
  final TextDirection? textDirection;

  /// Creates a [PickerTextStyle] with the given text styling properties.
  const PickerTextStyle({
    this.color,
    this.locale,
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

  /// Returns a copy of this [PickerTextStyle] with updated values.
  PickerTextStyle copyWith({
    Color? color,
    int? maxLines,
    double? height,
    Locale? locale,
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
      locale: locale ?? this.locale,
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
