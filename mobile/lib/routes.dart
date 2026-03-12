import 'package:get/get.dart';
import 'screens/home_screen.dart';
import 'screens/splash.dart';

class AppRoutes {
  static const String initial = '/';

  static final routes = [
    GetPage(
      name: initial,
      page: () => const SplashScreen(
        child: HomeScreen(),
      ),
    ),
  ];
}