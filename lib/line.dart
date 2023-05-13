abstract class Line {
  final String type;
  final String content;
  //text,barcode,qrcode,image(base64 string)
  Line({
    required this.type,
    required this.content,
  });
  Map<String, dynamic> toMap();
}
