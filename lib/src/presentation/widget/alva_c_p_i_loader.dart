import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/src/constants/my_constants.dart';

class AlvaCPILoader extends StatefulWidget {
  // circular progress indicator
  const AlvaCPILoader({Key? key}) : super(key: key);

  @override
  State<AlvaCPILoader> createState() => _AlvaCPILoaderState();
}

class _AlvaCPILoaderState extends State<AlvaCPILoader> with SingleTickerProviderStateMixin {
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
      child: Image.asset(LoaderConst().iconLoading, width: 64, height: 64),
      builder: (BuildContext context, Widget? child) => Transform.rotate(
        angle: _controller.value * 6.3,
        child: child,
      ),
    );
  }
}
