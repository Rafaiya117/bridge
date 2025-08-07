import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SelfLoveSlider extends StatefulWidget {
  const SelfLoveSlider({super.key});

  @override
  State<SelfLoveSlider> createState() => _SelfLoveSliderState();
}

class _SelfLoveSliderState extends State<SelfLoveSlider> {
  double _sliderPosition = 0.0;

  void _onSlideComplete() {
    context.go('/landing_page_two');
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double sliderWidth = constraints.maxWidth;
        final double sliderHeight = constraints.maxHeight;
        final double knobSize = sliderHeight;

        return Stack(
          children: [
            // Background
            Container(
              width: sliderWidth,
              height: sliderHeight,
              decoration: BoxDecoration(
                color: const Color(0xFFDFF1D6),
                borderRadius: BorderRadius.circular(40.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: knobSize), // Reserve knob space
                  const Text(
                    "Self Love",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  Row(
                    children: const [
                      Icon(Icons.chevron_right, color: Colors.green, size: 18),
                      Icon(Icons.chevron_right, color: Colors.green, size: 22),
                      Icon(Icons.chevron_right, color: Colors.green, size: 26),
                    ],
                  ),
                ],
              ),
            ),

            // Draggable Knob
            Positioned(
              left: _sliderPosition,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    _sliderPosition += details.delta.dx;
                    _sliderPosition = _sliderPosition.clamp(0.0, sliderWidth - knobSize);
                  });
                },
                onHorizontalDragEnd: (_) {
                  if (_sliderPosition >= sliderWidth - knobSize - 10) {
                    _onSlideComplete();
                  } else {
                    setState(() {
                      _sliderPosition = 0.0;
                    });
                  }
                },
                child: Container(
                  width: knobSize,
                  height: knobSize,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF009038),
                  ),
                  child: const Icon(Icons.chevron_right, color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
