import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/presentation/widget/alva_c_p_i_loader.dart';
import 'package:marketplace_line_oa/src/routes/routing_data.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late RouteSettings? settings;
  String redirectUrl = "";

  _redirectTo() {
    Future.delayed(const Duration(seconds: 5)).then((r) {
      String urlDecoded = Uri.decodeFull(redirectUrl);
      log('launch url auto: $urlDecoded');
      try {
        launchUrl(Uri.parse(urlDecoded));
      } catch (e) {
        log("launch fail: $e");
      }
    });
    Future.delayed(const Duration(seconds: 20)).then((r) {
      String urlDecoded = Uri.decodeFull(redirectUrl);
      log('launch url by clicked button: $urlDecoded');
      try {
        w.onDoubleTap!();
      } catch (e) {
        log("launch fail double tap: $e");
      }
    });
  }

  _loadSetting() {
    try {
      settings = ModalRoute.of(context) != null ? ModalRoute.of(context)!.settings : null;
      if (settings != null) {
        var uriData = Uri.parse(settings!.name!);
        var routingData = RoutingData(route: uriData.path, queryParameters: uriData.queryParameters);
        redirectUrl = (routingData["redirectUrl"] == null) ? "" : routingData["redirectUrl"];
        if (redirectUrl.isNotEmpty) {
          _redirectTo();
        }
      }
    } catch (e) {
      log("load setting exception: $e");
    }
  }

  late GestureDetector w;

  @override
  void initState() {
    _loadSetting();
    w = GestureDetector(
        onDoubleTap: () {
          _redirectTo();
        },
        child: AlvaCPILoader());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: maxWidth,
        height: maxHeight,
        color: Colors.white,
        child: Center(child: w),
      ),
    );
  }
}
