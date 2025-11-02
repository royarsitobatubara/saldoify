import 'package:go_router/go_router.dart';
import 'package:saldoify/screen/layouts/main_layout.dart';
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
          builder: (context, build) => MainLayout()
      ),
      GoRoute(
          path: '/transaction',
          builder: (context, build) => TransactionScreen()
      )
    ]
);