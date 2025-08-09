import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tha_bridge/components/constant.dart';
import 'package:tha_bridge/custom_widgets/custome_gradient_button.dart';
import 'package:tha_bridge/custom_widgets/custome_input.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirm_passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appColor,
      body: SafeArea(
          child: Center(
            child: Container(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  Image.asset('assets/images/logo.png'),
                  SizedBox(height: 20.h),
                  Image.asset('assets/images/reset_pass.png'),
                  SizedBox(height: 50.h),
                  CustomInputField(
                      label: 'Password',
                      hintText: '',
                      controller:passwordController ,
                     suffixIcon: Icon(Icons.visibility_off),
                  ),
                  SizedBox(height: 20.h,),
                  CustomInputField(
                    label: 'Confirm Password',
                    hintText: '',
                    controller:confirm_passwordController,
                    suffixIcon: Icon(Icons.visibility_off),
                  ),
                  SizedBox(height: 30.h,),
                  GradientButton(
                      text: 'Reset',
                      onPressed: (){
                        context.pop();
                      }
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}
