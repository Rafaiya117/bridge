import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOtpField extends StatefulWidget {
  final int numberOfFields;
  final double fieldWidth;
  final double fieldHeight;
  final double gapBetweenFields;
  final void Function(String)? onCompleted;

  const CustomOtpField({
    super.key,
    this.numberOfFields = 4,
    this.fieldWidth = 65,
    this.fieldHeight = 60,
    this.gapBetweenFields = 23,
    this.onCompleted,
  });

  @override
  CustomOtpFieldState createState() => CustomOtpFieldState();
}

class CustomOtpFieldState extends State<CustomOtpField> {
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(widget.numberOfFields, (_) => TextEditingController());
    focusNodes = List.generate(widget.numberOfFields, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

   String getOtp() {
    return controllers.map((e) => e.text).join();
  }
  void _checkCompletion() {
    final otp = controllers.map((e) => e.text).join();
    if (!otp.contains('') && otp.length == widget.numberOfFields) {
      widget.onCompleted?.call(otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.numberOfFields, (index) {
        return Padding(
          padding: EdgeInsets.only(
            right: index < widget.numberOfFields - 1 ? widget.gapBetweenFields.w : 0,
          ),
          child: SizedBox(
            width: widget.fieldWidth.w,
            height: widget.fieldHeight.h,
            child: TextField(
              controller: controllers[index],
              focusNode: focusNodes[index],
              maxLength: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 20),
              decoration: InputDecoration(
                counterText: "",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Color(0xFF512DA8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Color(0xFFABABAB), width: 1),
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty && index < widget.numberOfFields - 1) {
                  FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                } else if (value.isEmpty && index > 0) {
                  FocusScope.of(context).requestFocus(focusNodes[index - 1]);
                }

                _checkCompletion();
              },
            ),
          ),
        );
      }),
    );
  }
}
