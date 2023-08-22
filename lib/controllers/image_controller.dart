import 'dart:convert';
import 'dart:developer';
import 'dart:html';
import 'dart:js' as js;
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:get/get.dart';
import 'package:flutter/painting.dart';
import 'package:marketplace_line_oa/models/file_model.dart';
import 'package:url_launcher/url_launcher.dart';

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
      final base64 = base64Encode(fileModel.bytes);
      final anchor = AnchorElement(
          href: "data:application/octet-stream;charset=utf-16le;base64,$base64")
        ..setAttribute("download", "${fileModel.name}.${fileModel.ext}")
        ..click();
      success = true;
    } catch (e) {
      log(e.toString());
    }
    return success;
  }

  Future<bool> downloadFileUrlLauncher(FileModel fileModel) async {
    bool success = false;

    try {
      final base64 = base64Encode(fileModel.bytes);
      launch("https://img.freepik.com/premium-photo/image-colorful-galaxy-sky-generative-ai_791316-9864.jpg?w=1060");
      //launch("data:application/octet-stream;base64,$base64");
      // final Uri url = Uri.parse("data:application/octet-stream;base64,$base64");
      // final canlaunch = await canLaunchUrl(url);
      // print(canlaunch);
      // if(canlaunch) {
      //   launchUrl(url);
      // }
      success = true;
    } catch (e) {
      log(e.toString());
    }
    return success;
  }

  closeLiff() {
    FlutterLineLiff().closeWindow();
  }

  Future<bool> sendImageToLiff() async {
    try {
      String url = "https://st2.depositphotos.com/44162236/43268/v/600/depositphotos_432688360-stock-illustration-receipt-icon-in-a-flat.jpg";

      await FlutterLineLiff().sendMessages(
          messages: [
            const TextMessage(text: "ข้อมูลการชำระเงินของคุณ"),
            ImageMessage(
              originalContentUrl: url,
              previewImageUrl: url
          )
          ]
      );
      return true;
    } catch (e) {
      print("something went wrong liff with error: $e");
      return false;
    }
  }

  // Future<void> captureScreen(Uint8List bytes) async {
  //   // RenderRepaintBoundary boundary = rootWidgetKey.currentContext.findRenderObject() as RenderRepaintBoundary;
  //   // ui.Image image = await boundary.toImage(pixelRatio: 1.0);
  //   // ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //   Uint8List pngBytes = bytes.buffer.asUint8List();
  //
  //   html.Blob blob = html.Blob([pngBytes], 'image/png');
  //   String url = html.Url.createObjectUrlFromBlob(blob);
  //   js.context.callMethod('open', [url, '_blank']);
  //   html.Url.revokeObjectUrl(url);
  // }
}