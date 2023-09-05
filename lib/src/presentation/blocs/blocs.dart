import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/check_browser/check_browser_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/connectivity_status/connectivity_status_bloc.dart';

final List<BlocProvider> blocs = [
  BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
  BlocProvider<CheckBrowserBloc>(create: (_) => CheckBrowserBloc()),
  BlocProvider<ConnectivityStatusBloc>(create: (_) => ConnectivityStatusBloc()),
];
