import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tha_bridge/custom_widgets/custom_slider_button.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool _confirmed = false;

  final double sliderWidth = 300.w;
  final double sliderHeight = 65.h;
  final double knobSize = 65.w;

  void _onSlideEnd() {
    setState(() {
      _confirmed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD3EBBA),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100.h),
                Image.asset(
                  'assets/images/logo.png',
                  width: 320.w,
                  height: 220.h,
                  fit: BoxFit.contain,
                ),
                const Spacer(), // pushes slider down dynamically
                SizedBox(
                  width: 320.w,
                  height: 60.h,
                  child: const SelfLoveSlider(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
