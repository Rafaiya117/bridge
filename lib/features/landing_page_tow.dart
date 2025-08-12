import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LandingPageTow extends StatelessWidget {
  const LandingPageTow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/Vector_34.png',
              //width: 709.w, // from spec
              //height: 474.h, // from spec
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 58.h, // from spec
            left: 39.w, // from spec
            child: Image.asset(
              'assets/images/amico.png',
              width: 297.7186.w, // from spec
              height: 275.7491.h, // from spec
            ),
          ),
          Positioned(
            top: 430.h,
            left: 10.w,
            right: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My journey",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                    fontSize: 40.sp, // from spec
                    height: 50 / 40, // line-height ratio from spec
                    letterSpacing: 0,
                    color: Color(0xFF009038),
                  ),
                ),
                SizedBox(height: 20.h),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      height: 1.5,
                      color: Colors.black,
                    ),
                    children: [
                      const TextSpan(text: 'Your '),
                      TextSpan(
                        text: 'safe',
                        style: TextStyle(color: Color(0xFF009038)),
                      ),
                      const TextSpan(text: ' space for growth. '),
                      TextSpan(
                        text: 'Positive',
                        style: TextStyle(color: Color(0xFF009038)),
                      ),
                      const TextSpan(text: ' content, real\n '),
                      TextSpan(
                        text: 'guidance',
                        style: TextStyle(color: Color(0xFF009038)),
                      ),
                      const TextSpan(
                          text:
                          ', and a supportive community to help you\n stay balanced and inspired'),
                    ],
                  ),
                ),
                SizedBox(height: 60.h),
                Text(
                  "Walk with people with a purpose to identify\n your purpose in life",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    height: 1.25,
                    letterSpacing: 0,
                    color: Color(0xFF009038),
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Container(
                      width: 150.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: EdgeInsets.all(2),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF009038),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            context.go('/login');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            elevation: 0,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "Log In",
                            style: TextStyle(
                              fontSize: 20.sp, // from spec
                              height: 50 / 40, // from spec
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 45.w),
                    Container(
                      width: 150.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF009038), Color(0xFFEFFFF5)],
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: EdgeInsets.all(2),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFEFFFF5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            elevation: 0,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "Walk",
                            style: TextStyle(
                              fontSize: 20.sp, // from spec
                              height: 50 / 40, // from spec
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
