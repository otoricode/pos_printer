// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'line.dart';

class LineText extends Line {
  LineText({
    required super.content,
    this.size = 0,
    this.align = LineTextAlign.left,
    // this.weight = 0, //0,1
    // this.width = 0, //0,1
    // this.height = 0, //0,1
    // this.underline = 0, //0,1
    // this.linefeed = 0, //0,1
    this.x = 0,
    this.y = 0,
    // this.rotation = 0,
    this.xMul = 1,
    this.yMul = 1,
  }) : super(type: "text");

  // static const String TYPE_TEXT = 'text';
  // static const String TYPE_BARCODE = 'barcode';
  // static const String TYPE_QRCODE = 'qrcode';
  // static const String TYPE_IMAGE = 'image';
  // static const int ALIGN_CENTER = 1;
  // static const int ALIGN_RIGHT = 2;

  final int size;
  final LineTextAlign align;
  final int weight = 0;
  final int width = 0;
  final int height = 0;
  final int underline = 0;
  final int linefeed = 0;
  final int x;
  final int y;
  final String fontType = "0";
  final int rotation = 0;
  final int xMul;
  final int yMul;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'content': content,
      'size': size,
      'align': align.value(),
      'weight': weight,
      'width': width,
      'height': height,
      'underline': underline,
      'linefeed': linefeed,
      'x': x,
      'y': y,
      'font_type': fontType,
      'rotation': rotation,
      'x_multification': xMul,
      'y_multification': yMul,
    };
  }

  String toJson() => json.encode(toMap());
}

enum LineTextAlign { left, right, center }

extension LineTextAlignValue on LineTextAlign {
  int value() {
    switch (this) {
      case LineTextAlign.left:
        return 0;
      case LineTextAlign.center:
        return 1;
      case LineTextAlign.right:
        return 2;
    }
  }
}
