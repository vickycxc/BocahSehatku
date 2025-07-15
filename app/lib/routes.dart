import 'package:app/features/auth/view/pages/login_page.dart';
import 'package:app/features/auth/view/pages/onboarding_screen_page.dart';
import 'package:go_router/go_router.dart';

GoRouter authRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => OnboardingScreenPage()),
    GoRoute(path: '/login', builder: (context, state) => LoginPage()),
  ],
);
