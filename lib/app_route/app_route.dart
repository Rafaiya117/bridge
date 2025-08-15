import 'package:go_router/go_router.dart';
import 'package:tha_bridge/app_route/maintab.dart';
import 'package:tha_bridge/features/auths/change_passowrd.dart';
import 'package:tha_bridge/features/auths/forgot_password.dart';
import 'package:tha_bridge/features/auths/login.dart';
import 'package:tha_bridge/features/auths/otp_page.dart';
import 'package:tha_bridge/features/auths/reset_password.dart';
import 'package:tha_bridge/features/ladndingpage.dart';
import 'package:tha_bridge/features/landing_page_tow.dart';
import 'package:tha_bridge/features/auths/sign_up.dart';
import 'package:tha_bridge/features/pages/chat_details_page.dart';
import 'package:tha_bridge/features/pages/chatlist.dart';
import 'package:tha_bridge/features/pages/circlepage.dart';
import 'package:tha_bridge/features/pages/comment_page.dart';
import 'package:tha_bridge/features/pages/create_goal_page.dart';
import 'package:tha_bridge/features/pages/create_new_post.dart';
import 'package:tha_bridge/features/pages/demo_page.dart';
import 'package:tha_bridge/features/pages/feed.dart';
import 'package:tha_bridge/features/pages/goal_page.dart';
import 'package:tha_bridge/features/pages/guidancepage.dart';
import 'package:tha_bridge/features/pages/help_&_support.dart';
import 'package:tha_bridge/features/pages/journalpage.dart';
import 'package:tha_bridge/features/pages/mirrorpage.dart';
import 'package:tha_bridge/features/pages/motivation_page.dart';
import 'package:tha_bridge/features/pages/notepage.dart';
import 'package:tha_bridge/features/pages/notificationpage.dart';
import 'package:tha_bridge/features/pages/personal_post.dart';
import 'package:tha_bridge/features/pages/privacy_policypage.dart';
import 'package:tha_bridge/features/pages/term_service.dart';
import 'package:tha_bridge/features/pages/walk_page.dart';
import 'package:tha_bridge/features/pages/walking.dart';
import 'package:tha_bridge/features/pages/walking_chat_group.dart';
import 'package:tha_bridge/model/PostModel.dart';



final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // Auth + Standalone routes
    GoRoute(path: '/', builder: (_, __) => const DemoPage()),
    GoRoute(path: '/landing', builder: (_, __) => const LandingPage()),
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
    GoRoute(path: '/chatlist', builder: (_, __) => ChatListPage()),
    GoRoute(path: '/chat_details', builder: (_, __) => ChatDetailPage()),
    GoRoute(path: '/profile', builder: (_, __) => ProfilePage()),
    GoRoute(path: '/change_password', builder: (_, __) => ChangePasswordPage()),
    GoRoute(path: '/help_&_support', builder: (_, __) => HelpSupportPage()),
    GoRoute(path: '/privacy_policy', builder: (_, __) => PrivacyPolicyPage()),
    GoRoute(path: '/term_conditions', builder: (_, __) => TermsConditionsPage()),
    GoRoute(path: '/walking', builder: (_, __) => WalkingPage()),
    GoRoute(path: '/walk', builder: (_, __) => WalkPage()),
    GoRoute(path: '/set_goal_page', builder: (_, __) => SetGoalPage()),
    GoRoute(path: '/own_profile', builder: (_, __) => OwnProfilePage()),
    

    // ShellRoute: keeps bottom nav visible
    ShellRoute(
      builder: (context, state, child) {
        return MainTabScaffold(child: child);
      },
      routes: [
         GoRoute(
          path: '/video',
          builder: (_, __) => VideoFeedPage(),
        ),
         GoRoute(
          path: '/feed',
          builder: (_, __) => FeedPage(),
        ),
      
        // GoRoute(
        //   path: '/feed',
        //   builder: (_, __) => FeedPage(),
        // ),
        GoRoute(
          path: '/comments/:postId',
          builder: (context, state) {
          final postId = state.pathParameters['postId']!;
          return CommentPage(postId: postId);
       },
      ),
        GoRoute(
          path: '/new_post',
          builder: (_, __) => const CreateNewPost(),
        ),
        // GoRoute(
        //   path: '/goal',
        //   builder: (_, __) => const GoalPage(),
        // ),
        GoRoute(
          path: '/goal',
          builder: (context, state) {
          final GoalItem? newGoal = state.extra as GoalItem?;
          return GoalPage(newGoal: newGoal);
        },
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
