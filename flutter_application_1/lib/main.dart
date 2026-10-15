import 'package:flutter/material.dart';
import 'models/dummy_user.dart';
import 'screens/dashboard_screen.dart';
import 'screens/login_screen.dart';
import 'screens/reset_password_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/ticket_booking_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MuseumBrawijayaApp());
}

/// Root widget aplikasi mobile Museum Brawijaya
class MuseumBrawijayaApp extends StatelessWidget {
  const MuseumBrawijayaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Museum Brawijaya',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/reset-password': (context) => const ResetPasswordScreen(),
        '/dashboard': (context) => const DashboardScreen(
              user: DummyUser(
                email: 'demo@museum.test',
                password: 'Museum123!',
                name: 'Alexandra',
              ),
            ),
        '/booking': (context) => const TicketBookingScreen(),
      },
    );
  }
}
