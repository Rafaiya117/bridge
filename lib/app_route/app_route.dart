import 'package:go_router/go_router.dart';
import 'package:tha_bridge/features/auths/forgot_password.dart';
import 'package:tha_bridge/features/auths/login.dart';
import 'package:tha_bridge/features/auths/otp_page.dart';
import 'package:tha_bridge/features/auths/reset_password.dart';
import 'package:tha_bridge/features/ladndingpage.dart';
import 'package:tha_bridge/features/landing_page_tow.dart';
import 'package:tha_bridge/features/auths/sign_up.dart';
import 'package:tha_bridge/features/pages/comment_page.dart';
import 'package:tha_bridge/features/pages/create_new_post.dart';
import 'package:tha_bridge/features/pages/feed.dart';
import 'package:tha_bridge/model/PostModel.dart';


final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LandingPage(),
    ),
    GoRoute(
      path: '/landing_page_two',
      builder: (context, state) => const LandingPageTow(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: '/forgot_password',
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      path: '/otp_page',
      builder: (context,state)=>const OtpPage(),
    ),
    GoRoute(
      path: '/reset_password',
      builder: (context,state)=>const ResetPassword(),
    ),
    GoRoute(
      path: '/feed_page',
      builder: (context,state)=>const FeedPage(),
    ),
    GoRoute(
      path: '/comment_page',
      builder: (context,state)=>const CommentPage(),
    ),
    GoRoute(
      path: '/new_post',
      builder: (context,state)=>const CreateNewPost(),
    ),
  ],
);


