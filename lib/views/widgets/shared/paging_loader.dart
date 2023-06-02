import 'package:flutter/material.dart';
import 'package:marketplace_line_oa/helpers/extensions.dart';

class PagingLoader extends StatefulWidget {
  const PagingLoader({Key? key}) : super(key: key);

  @override
  State<PagingLoader> createState() => _PagingLoaderState();
}

class _PagingLoaderState extends State<PagingLoader> with SingleTickerProviderStateMixin {
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
      child: Image.asset('assets/icons/paging_loading.png', width: 32, height: 32),
      builder: (BuildContext context, Widget? child) => Transform.rotate(
        angle: _controller.value * 6.3,
        child: child,
      ),
    );
  }
}
