import 'package:go_router/go_router.dart';
import 'package:task_magazin/src/config/router/app_routes.dart';
import 'package:task_magazin/src/presentation/views/home/home_screen.dart';
import 'package:task_magazin/src/presentation/views/profile/widgets/user_cart.dart';
import 'package:task_magazin/src/presentation/views/splash/splash.dart';
import 'package:task_magazin/src/presentation/views/tab_box.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      name: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/tab_box',
      name: AppRoutes.tab,
      builder: (context, state) => const TabBox(),
    ),
    GoRoute(
      path: '/user_cart',
      name: AppRoutes.userCart,
      builder: (context, state) => const UserCart(
        userId: 1,
      ),
    ),
  ],
);
