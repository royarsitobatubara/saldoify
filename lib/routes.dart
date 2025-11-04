import 'package:go_router/go_router.dart';
import 'package:saldoify/screen/add_transaction_screen.dart';
import 'package:saldoify/screen/confirm_password_screen.dart';
import 'package:saldoify/screen/detail_transaction_screen.dart';
import 'package:saldoify/screen/edit_password_screen.dart';
import 'package:saldoify/screen/feedback_screen.dart';
import 'package:saldoify/screen/layouts/main_layout.dart';
import 'package:saldoify/screen/login_screen.dart';
import 'package:saldoify/screen/list_account.dart';
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
          builder: (context, state){
                final desc = state.extra.toString();
                return FeedbackScreen(description: desc,);
          }
      ),
      GoRoute(
          path: '/list-account',
          builder: (context, build) => const ListAccount()
      ),
      GoRoute(
          path: '/confirm-account',
          builder: (context, state) {
                final data = state.extra as Map<String, dynamic>;
                final id = data['id'];
                final name = data['name'];
                final password = data['password'];
                return ConfirmPasswordScreen(
                      id: id,
                      name: name,
                      password: password,
                );
          },
      ),
          GoRoute(
              path: '/edit-password',
              builder: (context, build) => const EditPasswordScreen()
          ),
      GoRoute(
          path: '/detail-transaction',
          builder: (context, state){
            final id = state.extra as int;
            return DetailTransactionScreen(id: id);
          }
      ),

    ]
);