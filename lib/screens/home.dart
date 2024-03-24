import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:shake_gesture/shake_gesture.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late GifController _controller;
  @override
  void initState() {
    _controller = GifController(vsync: this);
    super.initState();
  }

  void onShake() {
    log("shaked");
    if (_controller.isCompleted) {
      _controller.reset();
    } else {
      _controller.forward();
      Future.delayed(Durations.extralong1, () => _controller.stop());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ShakeGesture(
        onShake: onShake,
        child: Gif(
          image: const AssetImage("images/animate.gif"),
          controller:
              _controller, // if duration and fps is null, original gif fps will be used.
          //fps: 30,
          //duration: const Duration(seconds: 3),
          autostart: Autostart.no,
          placeholder: (context) => const Center(
            child: CircularProgressIndicator(
              strokeWidth: 6.0,
              strokeCap: StrokeCap.round,
            ),
          ),
        ),
      ),
    );
  }
}
