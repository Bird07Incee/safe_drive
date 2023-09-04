import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/auth/auth_bloc.dart';

final List<BlocProvider> blocs = [
  BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
];
