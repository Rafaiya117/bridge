import 'package:go_router/go_router.dart';
import 'package:tha_bridge/app_route/maintab.dart';
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
import 'package:tha_bridge/features/pages/goal_page.dart';
import 'package:tha_bridge/features/pages/guidancepage.dart';
import 'package:tha_bridge/features/pages/journalpage.dart';
import 'package:tha_bridge/features/pages/mirrorpage.dart';
import 'package:tha_bridge/features/pages/notepage.dart';
import 'package:tha_bridge/features/pages/notificationpage.dart';
import 'package:tha_bridge/features/pages/walking_chat_group.dart';
import 'package:tha_bridge/model/PostModel.dart';


final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // Auth + Standalone routes
    GoRoute(path: '/', builder: (_, __) => const LandingPage()),
    GoRoute(path: '/landing_page_two', builder: (_, __) => const LandingPageTow()),
    GoRoute(path: '/login', builder: (_, __) => const LoginPage()),
    GoRoute(path: '/signup', builder: (_, __) => const SignUpPage()),
    GoRoute(path: '/forgot_password', builder: (_, __) => const ForgotPasswordPage()),
    GoRoute(path: '/otp_page', builder: (_, __) => const OtpPage()),
    GoRoute(path: '/reset_password', builder: (_, __) => const ResetPassword()),
    // other page
    GoRoute(path: '/notifications', builder: (_, __) => NotificationScreen()),
    GoRoute(path: '/mirrorpage', builder: (_, __) => MirrorPage()),
    GoRoute(path: '/walkinggroupchat', builder: (_, __) => WalkingChatPage()),


    // ShellRoute: keeps bottom nav visible
    ShellRoute(
      builder: (context, state, child) {
        return MainTabScaffold(child: child); // <- includes your ReusableBottomNavBar
      },
      routes: [
        GoRoute(
          path: '/feed',
          builder: (_, __) => FeedPage(),
        ),
        GoRoute(
          path: '/comments',
          builder: (_, __) => const CommentPage(),
        ),
        GoRoute(
          path: '/new_post',
          builder: (_, __) => const CreateNewPost(),
        ),
        GoRoute(
          path: '/goal',
          builder: (_, __) => const GoalPage(),
        ),
        GoRoute(
          path: '/guidance',
          builder: (_, __) => const GuidancePage(),
        ),
        GoRoute(
          path: '/journal_page',
          builder: (_, __) => const JournalPage(),
        ),
        GoRoute(
          path: '/note',
          builder: (_, __) => const NotePage(),
        ),
        // Add other tabs as needed
      ],
    ),
  ],
);
