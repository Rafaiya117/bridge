import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tha_bridge/components/constant.dart';
import 'package:tha_bridge/custom_widgets/custome_gradient_button.dart';
import 'package:tha_bridge/custom_widgets/custom_auth_widgets/custome_input.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset('assets/images/logo.png'),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: 348.w,
                  height: 60.h,
                  child: CustomInputField(
                    label: 'User Email',
                    hintText: 'muffinworks@gmail.com',
                    controller: emailController,
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: 348.w,
                  height: 60.h,
                  child: CustomInputField(
                    label: 'Password',
                    hintText: '',
                    controller: passwordController,
                    suffixIcon: Icon(Icons.visibility_off),
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: 348.w,
                  height: 60.h,
                  child: CustomInputField(
                    label: 'Confirm Password',
                    hintText: '',
                    controller: confirmpassword,
                    suffixIcon: Icon(Icons.visibility_off),
                  ),
                ),
                SizedBox(height: 50.h),
                Row(
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _isChecked = newValue ?? false;
                        });
                      },
                      activeColor: _isChecked ? Color(0xFF009038) : Colors.white,
                      checkColor: Colors.white,
                    ),
                    SizedBox(width: 5.w),
                    RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          height: 1.5,
                          letterSpacing: 0,
                          color: Colors.white,
                        ),
                        children: [
                          const TextSpan(text: 'By Signing up, You’re agree to our '),
                          TextSpan(
                            text: 'Terms & Conditions\n',
                            style: TextStyle(color: Color(0xFF009038)),
                          ),
                          const TextSpan(text: 'and '),
                          TextSpan(
                            text: ' Privacy Policy',
                            style: TextStyle(color: Color(0xFF009038)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GradientButton(
                    text: 'Become',
                    onPressed: () {
                      context.go('/mirrorpage');
                    },
                  ),
                ),
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/gmail.png'),
                    SizedBox(width: 20.h),
                    Image.asset('assets/images/Apple.png'),
                  ],
                ),
                SizedBox(height: 15.h),
                Text.rich(
                  TextSpan(
                    text: "Already have an account? ",
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: 'Login In',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.push('/login');
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
