import 'package:flutter/material.dart';

class TimePickerDecoration {
  bool? isDense;
  bool? enabled;
  bool? filled;
  Widget? label;
  Widget? error;
  Locale? locale;
  bool? showCursor;
  Color? fillColor;
  Widget? prefixIcon;
  String? hintText;
  Color? hoverColor;
  int? errorMaxLines;
  Color? cursorColor;
  bool? fieldReadOnly;
  double? cursorWidth;
  TextStyle? textStyle;
  TextStyle? hintStyle;
  TextStyle? errorStyle;
  double? cursorHeight;
  Radius? cursorRadius;
  Offset? dropdownOffset;
  Color? cursorErrorColor;
  EdgeInsets? listPadding;
  InputBorder? errorBorder;
  InputBorder? focusedBorder;
  InputBorder? enabledBorder;
  BoxDecoration? menuDecoration;
  PickerTextStyle? pickerTextStyle;
  BorderRadiusGeometry? borderRadius;
  SuffixDecoration? suffixDecoration;
  EdgeInsetsGeometry? contentPadding;
  BoxConstraints? suffixIconConstraints;

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

class SuffixDecoration {
  TextStyle? textStyle;
  double? height, width;
  BoxDecoration? unSelectedDecoration;
  BoxDecoration? selectedDecoration;
  EdgeInsetsGeometry? padding;
  AlignmentGeometry? alignment;

  SuffixDecoration({
    this.width,
    this.height,
    this.padding,
    this.textStyle,
    this.alignment,
    this.selectedDecoration,
    this.unSelectedDecoration,
  });

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

class PickerTextStyle {
  final Color? color;
  final int? maxLines;
  final double? height;
  final double? fontSize;
  final Color? hoverColor;
  final String? fontFamily;
  final FontStyle? fontStyle;
  final TextAlign? textAlign;
  final double? letterSpacing;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final TextBaseline? textBaseline;
  final TextDirection? textDirection;

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
