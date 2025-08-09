import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tha_bridge/components/constant.dart';
import 'package:tha_bridge/custom_widgets/custom_otp_field.dart';
import 'package:tha_bridge/custom_widgets/custome_gradient_button.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appColor,
      body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png'),
                  SizedBox(height: 20.h),
                  Image.asset('assets/images/otp.png'),
                  SizedBox(height: 50.h),
                  CustomOtpField(),
                  SizedBox(height: 30.h),
                  GradientButton(
                      text: 'Verify',
                      onPressed: (){
                        context.go('/reset_password');
                      }
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
