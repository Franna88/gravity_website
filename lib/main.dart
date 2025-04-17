import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

// Screens
import 'screens/home_screen.dart';
import 'screens/activities_screen.dart';
import 'screens/parties_screen.dart';
import 'screens/play_parks_screen.dart';
import 'screens/escape_rooms_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/booking/basic_jump_booking.dart';

// Widgets
import 'widgets/loading_animation.dart';

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
    // Configure animation default settings
    Animate.restartOnHotReload = true;
    
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
        // Enhanced button styles
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 4,
            shadowColor: const Color(0xFFF36122).withOpacity(0.3),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
        // Card theme enhancements
        cardTheme: CardTheme(
          elevation: 5,
          shadowColor: Colors.black.withOpacity(0.2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
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

// Custom Page Transition
class FadeScaleTransition extends CustomTransitionPage<void> {
  FadeScaleTransition({
    required LocalKey key,
    required Widget child,
  }) : super(
          key: key,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ),
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.95, end: 1.0).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  ),
                ),
                child: child,
              ),
            );
          },
          child: child,
        );
}

// Interactive loading screen
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: GravityLoadingIndicator(
          size: 70,
          color: const Color(0xFFF36122),
        ),
      ),
    );
  }
}

// Router configuration
final GoRouter _router = GoRouter(
  // Add error handling for navigation
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.network(
            'https://assets2.lottiefiles.com/packages/lf20_s2lryxtd.json',
            width: 200,
            height: 200,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.error_outline,
                size: 100,
                color: Colors.red.shade300,
              );
            },
          ),
          const SizedBox(height: 20),
          Text(
            'Page not found: ${state.path}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => context.go('/'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF36122),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: const Text('GO HOME'),
          ),
        ],
      ),
    ),
  ),
  
  // Use redirect to show loading screen
  redirect: (BuildContext context, GoRouterState state) {
    return null; // No redirect needed, just continue to the destination
  },
  
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => FadeScaleTransition(
        key: state.pageKey,
        child: const HomeScreen(),
      ),
    ),
    GoRoute(
      path: '/activities',
      pageBuilder: (context, state) => FadeScaleTransition(
        key: state.pageKey,
        child: const ActivitiesScreen(),
      ),
    ),
    GoRoute(
      path: '/parties',
      pageBuilder: (context, state) => FadeScaleTransition(
        key: state.pageKey,
        child: const PartiesScreen(),
      ),
    ),
    GoRoute(
      path: '/play-parks',
      pageBuilder: (context, state) => FadeScaleTransition(
        key: state.pageKey,
        child: const PlayParksScreen(),
      ),
    ),
    GoRoute(
      path: '/escape-rooms',
      pageBuilder: (context, state) => FadeScaleTransition(
        key: state.pageKey,
        child: const EscapeRoomsScreen(),
      ),
    ),
    GoRoute(
      path: '/contact',
      pageBuilder: (context, state) => FadeScaleTransition(
        key: state.pageKey,
        child: const ContactScreen(),
      ),
    ),
    GoRoute(
      path: '/booking',
      pageBuilder: (context, state) => FadeScaleTransition(
        key: state.pageKey,
        child: const BasicJumpBookingScreen(),
      ),
    ),
  ],
);

