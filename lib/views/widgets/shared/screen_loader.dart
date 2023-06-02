import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/helpers/extensions.dart';

class ScreenIndicatorLoader extends StatefulWidget {
  const ScreenIndicatorLoader({Key? key}) : super(key: key);

  @override
  State<ScreenIndicatorLoader> createState() => _PagingLoaderState();
}

class _PagingLoaderState extends State<ScreenIndicatorLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: Image.asset('assets/icons/loading_indicator.png', width: 64, height: 64),
      builder: (BuildContext context, Widget? child) => Transform.rotate(
        angle: _controller.value * 6.3,
        child: child,
      ),
    );
  }
}
