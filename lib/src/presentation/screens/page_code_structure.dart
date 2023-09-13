import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/check_browser/check_browser_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/connectivity_status/connectivity_status_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/screens/error_screen.dart';
import 'package:marketplace_line_oa/src/presentation/screens/loading_screen.dart';

@override
Widget build(BuildContext context) {
  // var maxWidth = MediaQuery.of(context).size.width;
  // var maxHeight = MediaQuery.of(context).size.height;
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
            if (checkBrowserState is CheckBrowserLoading) {
              return const LoadingScreen();
            } else if (checkBrowserState is BrowserIsNotLineLiff) {
              return ErrorScreen(
                title: ErrorConst().titleBrowser,
                subTitle: ErrorConst().subTitleBrowser,
                titleBtn: ErrorConst().titleBtnBrowser,
                onTap: () {},
              );
            } else {
              ///code here
              return Container();
            }
          },
        );
      }
    },
  );
}

