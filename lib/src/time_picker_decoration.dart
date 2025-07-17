import 'package:flutter/material.dart';

class TimePickerDecoration {
  bool? isDense;
  bool? showCursor;
  Color? cursorColor;
  bool? fieldReadOnly;
  double? cursorWidth;
  double? cursorHeight;
  Radius? cursorRadius;
  Offset? dropdownOffset;
  Color? cursorErrorColor;
  EdgeInsets? listPadding;
  InputBorder? focusedBorder;
  InputBorder? enabledBorder;
  BoxDecoration? menuDecoration;
  SuffixDecoration? suffixDecoration;
  EdgeInsetsGeometry? contentPadding;
  BoxConstraints? suffixIconConstraints;

  TimePickerDecoration({
    this.isDense,
    this.showCursor,
    this.cursorWidth,
    this.cursorColor,
    this.listPadding,
    this.cursorHeight,
    this.cursorRadius,
    this.fieldReadOnly,
    this.enabledBorder,
    this.focusedBorder,
    this.dropdownOffset,
    this.contentPadding,
    this.menuDecoration,
    this.suffixDecoration,
    this.cursorErrorColor,
    this.suffixIconConstraints,
  });

  TimePickerDecoration.copyWith({
    bool? isDense,
    bool? showCursor,
    Color? cursorColor,
    double? cursorWidth,
    bool? fieldReadOnly,
    double? cursorHeight,
    Radius? cursorRadius,
    Offset? dropdownOffset,
    EdgeInsets? listPadding,
    Color? cursorErrorColor,
    InputBorder? enabledBorder,
    InputBorder? focusedBorder,
    BoxDecoration? menuDecoration,
    EdgeInsetsGeometry? contentPadding,
    SuffixDecoration? suffixDecoration,
    BoxConstraints? suffixIconConstraints,
  }) {
    TimePickerDecoration(
      isDense: isDense ?? this.isDense,
      showCursor: showCursor ?? this.showCursor,
      cursorColor: cursorColor ?? this.cursorColor,
      cursorWidth: cursorWidth ?? this.cursorWidth,
      listPadding: listPadding ?? this.listPadding,
      cursorHeight: cursorHeight ?? this.cursorHeight,
      cursorRadius: cursorRadius ?? this.cursorRadius,
      fieldReadOnly: fieldReadOnly ?? this.fieldReadOnly,
      enabledBorder: enabledBorder ?? this.enabledBorder,
      focusedBorder: focusedBorder ?? this.focusedBorder,
      dropdownOffset: dropdownOffset ?? this.dropdownOffset,
      contentPadding: contentPadding ?? this.contentPadding,
      menuDecoration: menuDecoration ?? this.menuDecoration,
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
