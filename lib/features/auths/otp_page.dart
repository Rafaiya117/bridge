import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tha_bridge/components/constant.dart';
import 'package:tha_bridge/custom_widgets/custom_auth_widgets/custom_otp_field.dart';
import 'package:tha_bridge/custom_widgets/custome_gradient_button.dart';

class OtpPage extends StatefulWidget {
  final String? email;
  const OtpPage({super.key, this.email});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
final GlobalKey<CustomOtpFieldState> otpKey = GlobalKey<CustomOtpFieldState>();

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
                  CustomOtpField(
                    numberOfFields: 4,
                    fieldWidth: 50.w,
                    fieldHeight: 60.h,
                    gapBetweenFields: 23,
                      onCompleted: (otp) {
                        print('OTP Entered: $otp');
                      },
                    ),

                  SizedBox(height: 30.h),
                  GradientButton(
                      text: 'Verify',
                      onPressed: (){
                        final otp = otpKey.currentState?.getOtp() ?? '';
                          print('OTP on Verify Pressed: $otp');
                            if (otp.length == 4) {
                              context.go('/reset_password', extra: {widget.email,otp});
                         } 
                       // context.go('/reset_password',extra: widget.email,);
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
