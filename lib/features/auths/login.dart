import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tha_bridge/components/constant.dart';
import 'package:tha_bridge/custom_widgets/custome_gradient_button.dart';
import 'package:tha_bridge/custom_widgets/custome_input.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    bool _isChecked = false;
    return Scaffold(
      backgroundColor:AppColor.appColor,
      body: SafeArea(
        child:SingleChildScrollView(
          child: Container(
            // margin: EdgeInsets.symmetric(horizontal: 12.h, vertical: 16.w),
            padding: EdgeInsets.all(18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset('assets/images/logo.png'),
                ),
                SizedBox(height: 20.h),
                CustomInputField(
                  label: 'User Email',
                  hintText: 'muffinworks@gmail.com',
                  controller: emailController,
                ),
                SizedBox(height: 20.h),
                CustomInputField(
                  label: 'Password',
                  hintText: '',
                  controller: passwordController,
                  suffixIcon: Icon(Icons.visibility_off),
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                     context.push('/forgot_password');
                    },
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFFF0000),
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                SizedBox(height: 50.h,),
                Row(
                  children: [
                    Checkbox(
                      value: _isChecked, // Current state
                      onChanged: (bool? newValue) {},
                      activeColor: _isChecked ? Color(0xFF009038):Colors.white,
                      checkColor: Colors.white,
                    ),
                    SizedBox(width: 5.w,),
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
                SizedBox(height: 50.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GradientButton(
                    text: 'Log In',
                    onPressed: () {
                      context.go('/feed_page');
                    },
                  ),
                ),
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/gmail.png'),
                    SizedBox(width: 20.h,),
                    Image.asset('assets/images/Apple.png'),
                  ],
                ),
                SizedBox(height: 15.h),
                Text.rich(
                  TextSpan(
                    text: "Don't have an account? ",
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign In',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                          context.go('/signup');
                          },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
