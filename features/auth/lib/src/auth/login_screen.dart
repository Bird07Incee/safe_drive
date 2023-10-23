import 'package:commons/res/images.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
            )
          ],
        ),
      ),
    ));
  }
}
