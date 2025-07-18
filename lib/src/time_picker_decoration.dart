import 'package:flutter/material.dart';

class TimePickerDecoration {
  bool? isDense;
  Locale? locale;
  bool? showCursor;
  Color? cursorColor;
  Color? hoverColor;
  bool? fieldReadOnly;
  double? cursorWidth;
  TextStyle? textStyle;
  double? cursorHeight;
  Radius? cursorRadius;
  Offset? dropdownOffset;
  Color? cursorErrorColor;
  EdgeInsets? listPadding;
  InputBorder? focusedBorder;
  InputBorder? enabledBorder;
  BoxDecoration? menuDecoration;
  PickerTextStyle? pickerTextStyle;
  BorderRadiusGeometry? borderRadius;
  SuffixDecoration? suffixDecoration;
  EdgeInsetsGeometry? contentPadding;
  BoxConstraints? suffixIconConstraints;

  TimePickerDecoration({
    this.locale,
    this.isDense,
    this.textStyle,
    this.hoverColor,
    this.showCursor,
    this.cursorWidth,
    this.cursorColor,
    this.listPadding,
    this.borderRadius,
    this.cursorHeight,
    this.cursorRadius,
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
    bool? isDense,
    Locale? locale,
    bool? showCursor,
    Color? hoverColor,
    Color? cursorColor,
    double? cursorWidth,
    bool? fieldReadOnly,
    double? cursorHeight,
    TextStyle? textStyle,
    Radius? cursorRadius,
    Offset? dropdownOffset,
    EdgeInsets? listPadding,
    Color? cursorErrorColor,
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
      locale: locale ?? this.locale,
      isDense: isDense ?? this.isDense,
      textStyle: textStyle ?? this.textStyle,
      hoverColor: hoverColor ?? this.hoverColor,
      showCursor: showCursor ?? this.showCursor,
      cursorColor: cursorColor ?? this.cursorColor,
      cursorWidth: cursorWidth ?? this.cursorWidth,
      listPadding: listPadding ?? this.listPadding,
      borderRadius: borderRadius ?? this.borderRadius,
      cursorHeight: cursorHeight ?? this.cursorHeight,
      cursorRadius: cursorRadius ?? this.cursorRadius,
      fieldReadOnly: fieldReadOnly ?? this.fieldReadOnly,
      enabledBorder: enabledBorder ?? this.enabledBorder,
      focusedBorder: focusedBorder ?? this.focusedBorder,
      dropdownOffset: dropdownOffset ?? this.dropdownOffset,
      contentPadding: contentPadding ?? this.contentPadding,
      menuDecoration: menuDecoration ?? this.menuDecoration,
      pickerTextStyle: pickerTextStyle ?? this.pickerTextStyle,
      suffixDecoration: suffixDecoration ?? this.suffixDecoration,
      cursorErrorColor: cursorErrorColor ?? this.cursorErrorColor,
      suffixIconConstraints: suffixIconConstraints ?? this.suffixIconConstraints,
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


