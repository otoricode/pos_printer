// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LineText {
  LineText({
    this.type = "text", //text,barcode,qrcode,image(base64 string)
    required this.content,
    this.size = 0,
    this.align = ALIGN_LEFT,
    this.weight = 0, //0,1
    this.width = 0, //0,1
    this.height = 0, //0,1
    this.underline = 0, //0,1
    this.linefeed = 0, //0,1
    this.x = 0,
    this.y = 0,
    this.font_type = "0",
    this.rotation = 0,
    this.x_multification = 1,
    this.y_multification = 1,
  });

  static const String TYPE_TEXT = 'text';
  static const String TYPE_BARCODE = 'barcode';
  static const String TYPE_QRCODE = 'qrcode';
  static const String TYPE_IMAGE = 'image';
  static const int ALIGN_LEFT = 0;
  static const int ALIGN_CENTER = 1;
  static const int ALIGN_RIGHT = 2;

  final String type;
  final String content;
  final int size;
  final int align;
  final int weight;
  final int width;
  final int height;
  final int underline;
  final int linefeed;
  final int x;
  final int y;
  final String font_type;
  final int rotation;
  final int x_multification;
  final int y_multification;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'content': content,
      'size': size,
      'align': align,
      'weight': weight,
      'width': width,
      'height': height,
      'underline': underline,
      'linefeed': linefeed,
      'x': x,
      'y': y,
      'font_type': font_type,
      'rotation': rotation,
      'x_multification': x_multification,
      'y_multification': y_multification,
    };
  }

  String toJson() => json.encode(toMap());
}
