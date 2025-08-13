import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tha_bridge/components/constant.dart';
import 'package:tha_bridge/custom_widgets/custome_gradient_button.dart';
import 'package:tha_bridge/custom_widgets/custom_auth_widgets/custome_input.dart';

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
                  Image.asset(
                    'assets/images/logo.png',
                    width: 247,
                    height: 181,
                  ),
                  SizedBox(height: 20.h),
                  Image.asset(
                    'assets/images/lock.png',
                    width: 201,
                    height: 100,
                  ),

                  SizedBox(height: 65.h),
                  SizedBox(
                    width: 348.w,
                    height: 60.h,
                    child: CustomInputField(
                      label: 'User Email',
                      hintText: 'muffinworks@gmail.com',
                      controller: emailController,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Center(
                      child: SizedBox(
                        width: 348.w,
                        height: 50,
                        child: GradientButton(
                          text: 'Verify',
                          onPressed: () {
                            context.go('/otp_page',extra: emailController.text);
                          },
                        ),
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
