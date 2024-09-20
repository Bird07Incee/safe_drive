import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class NonCacheNetworkImage extends StatelessWidget {
  const NonCacheNetworkImage(this.imageUrl, {super.key});
  final String imageUrl;
  Future<Uint8List> getImageBytes() async {
    Response response = await get(Uri.parse(imageUrl));
    return response.bodyBytes;
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    return FutureBuilder<Uint8List>(
      future: getImageBytes(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Image.memory(snapshot.data!, fit: BoxFit.fitWidth, cacheWidth: maxWidth.toInt() - 32, errorBuilder: (context, error, stackTrace) {
            return Image.asset('assets/homepage/img_default.png', fit: BoxFit.fitWidth);
          });
        }
        return Image.asset('assets/homepage/img_default.png', fit: BoxFit.fitWidth);
      },
    );
  }
}
