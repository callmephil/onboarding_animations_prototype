// ignore_for_file: prefer-single-widget-per-file, prefer-match-file-name

import 'package:animate_do/animate_do.dart';
import 'package:app/theme/app_colors.dart';
import 'package:app/theme/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _pageController = PageController();
  final ValueNotifier<int> _currentPage = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      _currentPage.value = _pageController.page?.round() ?? 0;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentPage.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage.value < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage.value > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/login');
                },
                child: const Padding(
                  padding: EdgeInsets.all(AppSizes.s24),
                  child: Text('Skip'),
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                children: const [
                  OnboardingView(
                    asset: 'assets/car_wash.svg',
                    title: 'Wash & Polish',
                    description: 'Done nasty things to your car? We can help!',
                  ),
                  OnboardingView(
                    asset: 'assets/car_tire.svg',
                    title: 'Tire Change',
                    description: "Lost a tire? We'll help you find a new one",
                  ),
                  OnboardingView(
                    asset: 'assets/car_fuel.svg',
                    title: 'Fuel Delivery',
                    description:
                        'Running away from the cops? We can help you get the extra miles!',
                  ),
                  OnboardingView(
                    asset: 'assets/car_parts.svg',
                    title: 'Spare Parts Shopping',
                    description:
                        r"Looking for new wipers? That'd be 101$ Please.",
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ValueListenableBuilder(
                valueListenable: _currentPage,
                builder: (_, index, child) {
                  if (index != 3) {
                    return const SizedBox(height: 48);
                  }

                  return child ?? const SizedBox();
                },
                child: FadeIn(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                    child: Text(
                      'Get Started',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSizes.s24),
              child: Row(
                children: [
                  ValueListenableBuilder(
                    valueListenable: _currentPage,
                    builder: (_, index, child) {
                      if (index == 0) {
                        return const SizedBox(width: 48);
                      }

                      return child ?? const SizedBox();
                    },
                    child: FadeIn(
                      child: IconButton.filled(
                        onPressed: _previousPage,
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.surface,
                          side: const BorderSide(color: AppColors.black),
                        ),
                        color: AppColors.black,
                        icon: const Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: _currentPage,
                      builder: (_, index, __) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 4,
                          children: [
                            for (var i = 0; i < 4; i++)
                              OnboardingProgressDot(
                                isSelected: i == index,
                                isPrimary: i >= index,
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: _currentPage,
                    builder: (_, index, child) {
                      if (index == 3) {
                        return const SizedBox(width: 48);
                      }

                      return child ?? const SizedBox();
                    },
                    child: FadeIn(
                      child: IconButton.filled(
                        onPressed: _nextPage,
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.black,
                          foregroundColor: AppColors.surface,
                        ),
                        icon: const Icon(Icons.arrow_forward),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingView extends StatelessWidget {
  const OnboardingView({
    super.key,
    required this.asset,
    required this.title,
    required this.description,
  });

  final String asset;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.s56),
      child: Column(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: FadeIn(
              duration: const Duration(milliseconds: 800),
              child: SvgPicture.asset(
                asset,
                colorFilter: const ColorFilter.mode(
                  AppColors.black,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          FadeInUp(
            duration: const Duration(milliseconds: 600),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          FadeInUp(
            duration: const Duration(milliseconds: 700),
            child: Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingProgressDot extends StatelessWidget {
  const OnboardingProgressDot({
    super.key,
    this.isSelected = true,
    this.isPrimary = true,
  });

  final bool isSelected;
  final bool isPrimary;

  static const _dropShadow = BoxShadow(
    color: Color.fromRGBO(15, 15, 25, 0.25),
    blurRadius: 4,
    offset: Offset(0, 6),
  );

  static const _isPrimaryDecoration = BoxDecoration(
    color: AppColors.black,
    borderRadius: AppSizes.borderRadius32,
    boxShadow: [_dropShadow],
  );

  static const _isSecondaryDecoration = BoxDecoration(
    color: AppColors.surface,
    border: Border(
      top: BorderSide(color: AppColors.black),
      bottom: BorderSide(color: AppColors.black),
      left: BorderSide(color: AppColors.black),
      right: BorderSide(color: AppColors.black),
    ),
    borderRadius: AppSizes.borderRadius32,
    boxShadow: [_dropShadow],
  );

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: isSelected ? 60 : 16,
      height: 16,
      decoration: isPrimary ? _isPrimaryDecoration : _isSecondaryDecoration,
    );
  }
}
