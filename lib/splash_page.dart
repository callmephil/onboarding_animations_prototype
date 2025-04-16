import 'package:animate_do/animate_do.dart';
import 'package:app/theme/app_colors.dart';
import 'package:app/theme/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 1250), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    final taglineStyle = Theme.of(context).textTheme.bodySmall;
    return Scaffold(
      body: Center(
        child: FadeIn(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/logo_light.svg',
                colorFilter:
                    const ColorFilter.mode(AppColors.black, BlendMode.srcIn),
              ),
              Text(AppStrings.tagline, style: taglineStyle),
            ],
          ),
        ),
      ),
    );
  }
}
