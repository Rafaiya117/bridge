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
      body: Column(
        children: [
          const Spacer(),
          Image.asset(
            'assets/images/logo.png',
            width: 357.w,
            height: 261.h,
            fit: BoxFit.contain,
          ),
          const Spacer(), // Push slider to bottom
          Padding(
            padding: EdgeInsets.only(bottom: 40.h),
            child: SizedBox(
              width: 340.w,
              height: 60.h,
              child: const SelfLoveSlider(),
            ),
          ),
        ],
      ),
    );
  }
}
