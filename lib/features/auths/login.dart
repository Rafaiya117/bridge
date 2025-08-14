import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tha_bridge/components/constant.dart';
import 'package:tha_bridge/custom_widgets/custome_gradient_button.dart';
import 'package:tha_bridge/custom_widgets/custom_auth_widgets/custome_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isChecked = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          /////////  Top Section //////////
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30.h),
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 290.w,
                      height: 212.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 20.h),

          ////////// Email Field //////////
                  CustomInputField(
                    label: 'User Email',
                    hintText: 'muffinworks@gmail.com',
                    controller: emailController,
                  ),
                  SizedBox(height: 20.h),

          ////////// Password Field /////////
                  CustomInputField(
                    label: 'Password',
                    hintText: '',
                    controller: passwordController,
                    obscureText: true,
                    suffixIcon: Icon(Icons.visibility_off),
                  ),
                  SizedBox(height: 20.h),

          //////// Forgot Password  //////////
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => context.push('/forgot_password'),
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),

                  /// 🔹 Terms & Conditions Checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: _isChecked,
                        onChanged: (bool? newValue) {
                          setState(() => _isChecked = newValue ?? false);
                        },
                        activeColor: const Color(0xFF009038),
                        checkColor: Colors.white,
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black87,
                              height: 1.5,
                            ),
                            children: [
                              const TextSpan(text: 'By Signing up, You’re agree to our '),
                              TextSpan(
                                text: 'Terms & Conditions\n',
                                style: TextStyle(color: Color(0xFF009038)),
                              ),
                              const TextSpan(text: 'and '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(color: Color(0xFF009038)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              /// 🔹 Bottom Section
              Column(
                children: [
                  /// 🔹 Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 55.h,
                    child: GradientButton(
                      text: 'Log In',
                      onPressed: () {
                        context.go('/video');
                      },
                    ),
                  ),
                  SizedBox(height: 15.h),

                  /// 🔹 Social Media Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/gmail.png'),
                      SizedBox(width: 20.w),
                      Image.asset('assets/images/Apple.png'),
                    ],
                  ),
                  SizedBox(height: 15.h),

                  /// 🔹 Sign Up Navigation
                  Text.rich(
                    TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                      children: [
                        TextSpan(
                          text: 'Sign In',
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => context.go('/signup'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}