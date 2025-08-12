import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      context.go('/landing');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.jpeg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            top: 256.0,
            left: 9.0,
            child: Image.asset(
              'assets/images/logo.png',
              width: 357.0,
              height: 261.0,
            ),
          ),
        ],
      ),
    );
  }
}

