// ignore_for_file: prefer-single-widget-per-file, prefer-match-file-name

import 'package:animate_do/animate_do.dart';
import 'package:app/theme/app_colors.dart';
import 'package:app/theme/app_sizes.dart';
import 'package:app/theme/app_strings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// A helper widget that passes the [child] through a [builder].
class ChildBuilder extends StatelessWidget {
  const ChildBuilder({super.key, required this.builder, this.child});

  final TransitionBuilder builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) => builder(context, child);
}

/// The refactored login page composed of smaller widgets.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static final GlobalKey _registerSectionKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.endOfFrame.then((_) {
      if (!mounted) return;
      _emailFocusNode.addListener(() {
        if (_emailFocusNode.hasFocus) {
          // know if we need to scroll or not is keyboard open?
          // if (_registerSectionKey.currentContext?.findRenderObject()
          //     case final object?) {
          //   final offset = (object as RenderBox).localToGlobal(Offset.zero);
          //   _scrollController.animateTo(
          //     offset.dy,
          //     duration: const Duration(milliseconds: 300),
          //     curve: Curves.easeInOut,
          //   );
          // }
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final resizeToAvoidBottomInset = size.height < 740;

    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: ChildBuilder(
          builder: (_, child) {
            final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
            return SizedBox(
              height: resizeToAvoidBottomInset
                  ? size.height
                  : size.height - bottomInset,
              width: size.width,
              child: child,
            );
          },
          child: SafeArea(
            minimum: const EdgeInsets.all(AppSizes.s16),
            child: Column(
              spacing: AppSizes.s12,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Flexible(
                  flex: 2,
                  child: ControlledSlideInUp(
                    delay: Duration(milliseconds: 100),
                    duration: Duration(milliseconds: 700),
                    child: LogoSection(),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ControlledSlideInUp(
                    delay: const Duration(milliseconds: 100),
                    child: LoginForm(
                      registerButtonKey: _registerSectionKey,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      emailFocusNode: _emailFocusNode,
                      passwordFocusNode: _passwordFocusNode,
                    ),
                  ),
                ),
                Visibility(
                  visible: MediaQuery.viewInsetsOf(context).bottom < 30,
                  child: const ControlledSlideInUp(
                    delay: Duration(milliseconds: 100),
                    duration: Duration(milliseconds: 900),
                    child: RegisterSection(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Displays the logo and tagline.
class LogoSection extends StatelessWidget {
  const LogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final taglineStyle = Theme.of(context).textTheme.bodySmall;
    return Column(
      spacing: AppSizes.s8,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: SvgPicture.asset(
            'assets/logo_light.svg',
            colorFilter:
                const ColorFilter.mode(AppColors.black, BlendMode.srcIn),
          ),
        ),
        Text(AppStrings.tagline, style: taglineStyle),
      ],
    );
  }
}

/// Displays the email/password fields, forgot password link and login button.
class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    this.registerButtonKey,
    this.emailController,
    this.passwordController,
    this.emailFocusNode,
    this.passwordFocusNode,
  });

  final GlobalKey? registerButtonKey;
  final FocusNode? emailFocusNode;
  final TextEditingController? emailController;
  final FocusNode? passwordFocusNode;
  final TextEditingController? passwordController;

  @override
  Widget build(BuildContext context) {
    final forgotPasswordStyle = Theme.of(context).textTheme.labelSmall;
    return Form(
      child: Column(
        spacing: AppSizes.s32,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            spacing: AppSizes.s12,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text('Login', style: Theme.of(context).textTheme.titleMedium),
              TextFormField(
                controller: emailController,
                focusNode: emailFocusNode,
                decoration:
                    const InputDecoration(hintText: AppStrings.emailHint),
              ),
              TextFormField(
                controller: passwordController,
                focusNode: passwordFocusNode,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration:
                    const InputDecoration(hintText: AppStrings.passwordHint),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password Required';
                  }
                  return null;
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child:
                    Text(AppStrings.forgotPassword, style: forgotPasswordStyle),
              ),
            ],
          ),
          ElevatedButton(
            key: registerButtonKey,
            onPressed: () {},
            child: const Text(AppStrings.login),
          ),
          // ChildBuilder(
          //   builder: (_, child) {
          //     final inset = MediaQuery.viewInsetsOf(context).bottom;
          //     return inset > 0 ? const SizedBox.shrink() : child!;
          //   },
          //   child: const Expanded(child: SocialLoginButtons()),
          // ),
        ],
      ),
    );
  }
}

/// Displays the register prompt and register button.
class RegisterSection extends StatelessWidget {
  const RegisterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final recognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pushNamed(context, '/register');
      };

    return Text.rich(
      TextSpan(
        text: '${AppStrings.dontHaveAccount} ',
        style: bodyMedium,
        children: [
          TextSpan(
            text: AppStrings.register,
            style: bodyMedium?.copyWith(
              decoration: TextDecoration.underline,
            ),
            recognizer: recognizer,
          ),
        ],
      ),
    );
  }
}

class ControlledSlideInUp extends StatefulWidget {
  const ControlledSlideInUp({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.delay = Duration.zero,
  });

  final Widget child;

  final Duration duration;
  final Duration delay;

  @override
  State<ControlledSlideInUp> createState() => _ControlledSlideInUpState();
}

class _ControlledSlideInUpState extends State<ControlledSlideInUp> {
  // ignore: dispose-fields
  late AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.endOfFrame.then((_) {
      if (!mounted) return;
      _controller?.forward();
    });
  }

  @override
  void dispose() {
    // _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideInUp(
      duration: widget.duration,
      delay: widget.delay,
      manualTrigger: true,
      controller: (controller) {
        _controller = controller;
      },
      child: widget.child,
    );
  }
}
