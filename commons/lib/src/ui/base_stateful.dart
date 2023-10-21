import 'package:commons/commons.dart';
import 'package:commons/src/ui/listener/base_state_listenner.dart';
import 'package:flutter/material.dart';

abstract class BaseStatefulWidget<T extends BaseViewModel>
    extends StatefulWidget {
  const BaseStatefulWidget({Key? key}) : super(key: key);

  T viewModel();
}

abstract class BaseState<T extends BaseStatefulWidget> extends State<T>
    with BaseStateListener {
  late final _viewModel = widget.viewModel();

}
