import 'package:commons/res/images.dart';
import 'package:flutter/material.dart';

class BackgroundApp extends StatelessWidget {
  const BackgroundApp({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                top: 0,
                right: 0,
                child: Image.asset(
                  AppImage.top1,
                  width: size.width,
                  color: Colors.red,
                )),
            Positioned(
                top: 0,
                right: 0,
                child: Image.asset(
                  AppImage.top2,
                  width: size.width,
                  color: Colors.red,
                )),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                AppImage.bottom1,
                width: size.width,
                color: Colors.red,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                AppImage.bottom2,
                width: size.width,
                color: Colors.red,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: child,
            )
          ],
        ),
      ),
    ));
  }
}
