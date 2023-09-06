import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:marketplace_line_oa/src/presentation/blocs/auth/auth_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FlutterLineLiff().init(
        config: Config(liffId: '1661164508-Kn9nO7oB'),
        successCallback: () {
          print('successCallback');
        },
        errorCallback: (error) {
          print('init error: ${error.name}, ${error.message}, ${error.stack}');
        });
    context.read<AuthBloc>().add(UserAuthEventLogin(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return const Text("test");
  }
}
