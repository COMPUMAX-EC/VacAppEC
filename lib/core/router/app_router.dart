// Removed material import
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/animals/screens/animal_form_screen.dart';
import '../../features/animals/screens/qr_scanner_screen.dart';
import '../../features/animals/screens/animal_detail_screen.dart';
import '../../features/health/screens/health_list_screen.dart';
import '../../features/health/screens/health_form_screen.dart';
import '../../features/animals/models/animal_model.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isLoggedIn = FirebaseAuth.instance.currentUser != null;
      final path = state.uri.path;
      final isLoggingIn = path == '/login';

      if (!isLoggedIn && !isLoggingIn) return '/login';
      if (isLoggedIn && isLoggingIn) return '/dashboard';

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) => '/dashboard',
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/animal-register',
        builder: (context, state) => const AnimalFormScreen(),
      ),
      GoRoute(
        path: '/animal-detail',
        builder: (context, state) => AnimalDetailScreen(animal: state.extra as AnimalModel),
      ),
      GoRoute(
        path: '/qr-scan',
        builder: (context, state) => QrScannerScreen(nextRoute: state.extra as String?),
      ),
      GoRoute(
        path: '/health-list',
        builder: (context, state) => HealthListScreen(animalId: state.extra as String),
      ),
      GoRoute(
        path: '/health-form',
        builder: (context, state) => HealthFormScreen(animalId: state.extra as String),
      ),
    ],
  );
}
