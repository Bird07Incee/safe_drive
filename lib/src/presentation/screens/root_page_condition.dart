import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/configs/enivironment_config.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/check_browser/check_browser_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/connectivity_status/connectivity_status_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/screens/error_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/loading_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class RootPageCondition extends StatefulWidget {
  final Widget child;
  const RootPageCondition({super.key, required this.child});

  @override
  State<RootPageCondition> createState() => _RootPageConditionState();
}

class _RootPageConditionState extends State<RootPageCondition> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initFunction();
  }

  Future<void> openLine() async {
    final Uri deepLink = Uri.parse(HomeConst().lineOAURL);
    if (!await launchUrl(deepLink)) {
      throw Exception('Could not launch $deepLink');
    }
  }

  initFunction() {
    context.read<CheckBrowserBloc>().add(GetBrowserClient(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityStatusBloc, ConnectivityStatusState>(
      builder: (context, errorNWState) {
        if (errorNWState is NoInternet) {
          return ErrorScreen(
            title: ErrorConst().titleNS,
            subTitle: ErrorConst().subTitleNS,
            titleBtn: ErrorConst().titleBtnNS,
            onTap: () {},
          );
        } else {
          return BlocBuilder<CheckBrowserBloc, CheckBrowserState>(
            builder: (context, checkBrowserState) {
              final env = Environment().getValue("ENVIRONMENT_NAME");
              if (checkBrowserState is CheckBrowserInitial || checkBrowserState is CheckBrowserLoading) {
                return const LoadingScreen();
              } else if (checkBrowserState is BrowserIsNotLineLiff && (env == 'uat' || env == 'prod')) {
                return ErrorScreen(
                  title: ErrorConst().titleBrowser,
                  subTitle: ErrorConst().subTitleBrowser,
                  titleBtn: ErrorConst().titleBtnBrowser,
                  onTap: () {
                    openLine();
                  },
                );
              } else {
                ///code here
                context.read<AuthBloc>().add(UserAuthEventLogin(context: context));
                return widget.child;
              }
            },
          );
        }
      },
    );
  }
}
