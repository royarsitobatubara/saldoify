import 'package:go_router/go_router.dart';
import 'package:saldoify/screen/add_transaction_screen.dart';
import 'package:saldoify/screen/feedback_screen.dart';
import 'package:saldoify/screen/layouts/main_layout.dart';
import 'package:saldoify/screen/login_screen.dart';
import 'package:saldoify/screen/profile_screen.dart';
import 'package:saldoify/screen/settings_screen.dart';
import 'package:saldoify/screen/register_screen.dart';
import 'package:saldoify/screen/splash_screen.dart';
import 'package:saldoify/screen/transaction_screen.dart';

final router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, build) => const SplashScreen()
      ),
      GoRoute(
          path: '/home',
          builder: (context, build) => const MainLayout()
      ),
      GoRoute(
          path: '/transaction',
          builder: (context, build) => const TransactionScreen()
      ),
      GoRoute(
        path: '/login',
        builder: (context, build) =>const LoginScreen()
      ),
      GoRoute(
          path: '/register',
          builder: (context, build) =>const RegisterScreen()
      ),
      GoRoute(
          path: '/add-transaction',
          builder: (context, build) => const AddTransactionScreen()
      ),
      GoRoute(
          path: '/settings',
          builder: (context, build) => const SettingsScreen()
      ),
      GoRoute(
          path: '/feedback',
          builder: (context, build) => const FeedbackScreen()
      ),
          GoRoute(
              path: '/profile',
              builder: (context, build) => const ProfileScreen()
          )
    ]
);