import 'dart:developer';
import 'dart:html';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:flutter/painting.dart';
import 'package:marketplace_line_oa/models/file_model.dart';

enum ImageType {
  /// Animated Portable Network Graphics (APNG)
  apng('image/apng'),

  /// AV1 Image File Format (AVIF)
  avif('image/avif'),

  /// Graphics Interchange Format (GIF)
  gif('image/gif'),

  /// Joint Photographic Expert Group image (JPEG)
  jpeg('image/jpeg'),

  /// Portable Network Graphics (PNG)
  png('image/png'),

  /// Scalable Vector Graphics (SVG)
  svg('image/svg+xml'),

  /// Web Picture format (WEBP)
  webp('image/webp');

  const ImageType(this.format);

  final String format;
}

class ImageController extends GetxController {

  /// Download image from uInt8List to user device
  Future<void> downloadImageFromUInt8List({
    required Uint8List uInt8List,
    double imageQuality = 0.95,
    String? name,
    ImageType imageType = ImageType.png,
  }) async {
    final image = await decodeImageFromList(uInt8List);

    final CanvasElement canvas = CanvasElement(
      height: image.height,
      width: image.width,
    );

    final ctx = canvas.context2D;

    final List<String> binaryString = [];

    for (final imageCharCode in uInt8List) {
      final charCodeString = String.fromCharCode(imageCharCode);
      binaryString.add(charCodeString);
    }
    final data = binaryString.join();

    final base64 = window.btoa(data);

    final img = ImageElement();

    img.src = "data:${imageType.format};base64,$base64";

    final ElementStream<Event> loadStream = img.onLoad;

    loadStream.listen((event) {
      ctx.drawImage(img, 0, 0);
      final dataUrl = canvas.toDataUrl(imageType.format, imageQuality);
      final AnchorElement anchorElement =
      AnchorElement(href: dataUrl);
      anchorElement.download = name ?? dataUrl;
      anchorElement.click();
    });
  }

  Future<bool> downloadFile(FileModel fileModel) async {
    bool success = false;

    try {
      String url = Url.createObjectUrlFromBlob(
          Blob([fileModel.bytes], fileModel.mimeType));

      HtmlDocument htmlDocument = document;
      AnchorElement anchor = htmlDocument.createElement('a') as AnchorElement;
      anchor.href = url;
      anchor.style.display = fileModel.name + fileModel.ext;
      anchor.download = fileModel.name;
      document.body!.children.add(anchor);
      anchor.click();
      document.body!.children.remove(anchor);
      success = true;
    } catch (e) {
      log(e.toString());
    }
    return success;
  }
}