import 'package:go_router/go_router.dart';
import 'package:tha_bridge/features/forgot_password.dart';
import 'package:tha_bridge/features/ladndingpage.dart';
import 'package:tha_bridge/features/landing_page_tow.dart';
import 'package:tha_bridge/features/login.dart';
import 'package:tha_bridge/features/sign_up.dart';

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
  ],
);


