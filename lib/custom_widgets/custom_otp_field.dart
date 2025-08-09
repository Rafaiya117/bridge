import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOtpField extends StatefulWidget {
  @override
  _CustomOtpFieldState createState() => _CustomOtpFieldState();
}

class _CustomOtpFieldState extends State<CustomOtpField> {
  final int numberOfFields = 4;
  final double gap = 23.w;
  final double fieldSize = 65.w; // ✅ perfect square size

  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(numberOfFields, (_) => TextEditingController());
    focusNodes = List.generate(numberOfFields, (_) => FocusNode());
  }

  @override
  void dispose() {
    controllers.forEach((c) => c.dispose());
    focusNodes.forEach((f) => f.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(numberOfFields, (index) {
        return Padding(
          padding: EdgeInsets.only(right: index < numberOfFields - 1 ? gap : 0),
          child: SizedBox(
            width: fieldSize,
            height: fieldSize, // ✅ same as width → perfect square
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
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF512DA8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFABABAB), width: 1),
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty && index < numberOfFields - 1) {
                  FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                } else if (value.isEmpty && index > 0) {
                  FocusScope.of(context).requestFocus(focusNodes[index - 1]);
                }
              },
            ),
          ),
        );
      }),
    );
  }
}
