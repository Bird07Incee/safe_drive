import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplace_line_oa/constants/router/route_config.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image.asset(
          //   'assets/images/404_error.png',
          //   fit: BoxFit.cover,
          //   height: MediaQuery.of(context).size.height - 40,
          //   width: MediaQuery.of(context).size.width,
          // ),
          const Positioned(
            bottom: 230,
            left: 30,
            child: Text(
              'Dead End',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const Positioned(
            bottom: 170,
            left: 30,
            child: Text(
              'Oops! The page you are looking for\nis not found',
              style: TextStyle(
                color: Colors.white54,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Positioned(
            bottom: 100,
            left: 30,
            right: 250,
            child: InkWell(
              onTap: () {
                Get.offAllNamed(RouteName.landing);
              },
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: const Center(
                    child: Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 16,
                        color:  Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}