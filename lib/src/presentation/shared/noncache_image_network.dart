import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NonCacheNetworkImage extends StatelessWidget {
  const NonCacheNetworkImage(this.imageUrl, {super.key});
  final String imageUrl;
  Future<Uint8List> getImageBytes() async {
    Dio dio = Dio();
    Response response = await dio.get(imageUrl, options: Options(responseType: ResponseType.bytes));
    ByteData byteData = ByteData.sublistView(response.data);
    return byteData.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio.toInt();
    return FutureBuilder<Uint8List>(
      future: getImageBytes(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Image.memory(snapshot.data!, fit: BoxFit.fitWidth, cacheWidth: (maxWidth.toInt() - 32) * devicePixelRatio,
              errorBuilder: (context, error, stackTrace) {
            return Image.asset('assets/homepage/img_default.png', fit: BoxFit.fitWidth);
          });
        }
        return Image.asset('assets/homepage/img_default.png', fit: BoxFit.fitWidth);
      },
    );
  }
}
