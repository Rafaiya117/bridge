import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tha_bridge/components/constant.dart';
import 'package:tha_bridge/custom_widgets/custome_gradient_button.dart';
import 'package:tha_bridge/custom_widgets/custome_input.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appColor,
      body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Center(
              child: Column(
                children: [
                  Image.asset('assets/images/logo.png'),
                  SizedBox(height: 20.h),
                  Image.asset('assets/images/lock.png'),
                  SizedBox(height: 65.h),
                  CustomInputField(
                    label: 'User Email',
                    hintText: 'muffinworks@gmail.com',
                    controller: emailController,
                  ),
                  SizedBox(height: 30.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Center(
                      child: GradientButton(
                        text: 'Verify',
                        //width: 800,
                        onPressed: () {
                          context.go('/otp_page');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ),
      ),
    );
  }
}
