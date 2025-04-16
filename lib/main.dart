import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

// Screens
import 'screens/home_screen.dart';
import 'screens/activities_screen.dart';
import 'screens/parties_screen.dart';
import 'screens/play_parks_screen.dart';
import 'screens/escape_rooms_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/booking/basic_jump_booking.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  
  // Error handling for production
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    if (kReleaseMode) {
      // In release mode, errors could be logged to a service
      debugPrint('Error in release mode: ${details.exception}');
    }
  };

  // Clear image cache to help with memory
  imageCache.clear();
  imageCache.clearLiveImages();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Gravity',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF36122),
          primary: const Color(0xFFF36122),
          secondary: const Color(0xFF87C540),
          background: Colors.white,
          surface: Colors.white,
        ),
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
        useMaterial3: true,
      ),
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 600, name: MOBILE),
          const Breakpoint(start: 601, end: 900, name: TABLET),
          const Breakpoint(start: 901, end: 1200, name: DESKTOP),
          const Breakpoint(start: 1201, end: double.infinity, name: 'XL'),
        ],
      ),
      routerConfig: _router,
    );
  }
}

// Router configuration
final GoRouter _router = GoRouter(
  // Add error handling for navigation
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Page not found: ${state.path}'),
    ),
  ),
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/activities',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ActivitiesScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/parties',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const PartiesScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/play-parks',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const PlayParksScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/escape-rooms',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const EscapeRoomsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/contact',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ContactScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: '/booking',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const BasicJumpBookingScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
  ],
);

