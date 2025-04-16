import 'package:app/login_page.dart';
import 'package:app/onboarding_page.dart';
import 'package:app/register_page.dart';
import 'package:app/splash_page.dart';
import 'package:app/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(
  //     // statusBarColor: AppColors.black,
  //     statusBarBrightness: Brightness.dark,
  //   ),
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData,
        title: 'Flutter Demo',
        home: const SplashPage(),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return SlideTransitionPage(
                direction: SlideTransitionPage.topToBottom,
                pageBuilder: (_, animation, secondaryAnimation) {
                  return const LoginPage();
                },
              );
            case '/onboarding':
              return FadeOutFadeInPage(
                pageBuilder: (_, animation, secondaryAnimation) {
                  return const OnboardingPage();
                },
              );
            case '/register':
              return SlideTransitionPage(
                pageBuilder: (_, animation, secondaryAnimation) {
                  return const RegisterPage();
                },
              );
            default:
              return null;
          }
        },
      ),
    );
  }
}

class SlideTransitionPage extends PageRouteBuilder<Widget> {
  SlideTransitionPage({
    required super.pageBuilder,
    Offset direction = leftToRight,
  }) : super(
          transitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            const end = Offset.zero;
            const curve = Curves.easeOut;

            final tween = Tween(begin: direction, end: end)
                .chain(CurveTween(curve: curve));
            final offsetAnimation = CurvedAnimation(
              parent: animation,
              curve: const Interval(0, 1, curve: curve),
            ).drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
        );

  static const leftToRight = Offset(1, 0);
  static const rightToLeft = Offset(-1, 0);
  static const topToBottom = Offset(0, 1);
  static const bottomToTop = Offset(0, -1);
}

class FadeOutFadeInPage extends PageRouteBuilder<Widget> {
  FadeOutFadeInPage({required super.pageBuilder})
      : super(
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            const curve = Curves.easeOut;

            return FadeTransition(
              opacity: CurvedAnimation(parent: animation, curve: curve),
              child: child,
            );
          },
        );
}
