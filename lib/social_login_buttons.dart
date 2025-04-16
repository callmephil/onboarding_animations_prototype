import 'package:app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        spacing: 8,
        children: [
          // Expanded(
          //   flex: 5,
          //   child: FilledButton(
          //     style: ButtonStyle(
          //       backgroundColor: WidgetStateProperty.all(AppColors.black),
          //       shape: WidgetStateProperty.all(
          //         const RoundedRectangleBorder(
          //           borderRadius: BorderRadius.all(Radius.circular(4)),
          //         ),
          //       ),
          //       minimumSize:
          //           WidgetStateProperty.all(const Size(double.infinity, 48)),
          //     ),
          //     onPressed: () {},
          //     child: Text(
          //       'Login',
          //       style: GoogleFonts.roboto().copyWith(
          //         color: AppColors.surface,
          //         fontSize: 26,
          //       ),
          //     ),
          //   ),
          // ),
          Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ColoredBox(
                color: Colors.black26,
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width / 3,
                  height: 1,
                ),
              ),
              // Divider(color: Colors.black26.withValues(alpha: 0.5)),
              const Text('OR'),
              ColoredBox(
                color: Colors.black26,
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width / 3,
                  height: 1,
                ),
              ),
              // Divider(color: Colors.black26.withValues(alpha: 0.5)),
            ],
          ),
          Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                child: const SizedBox.square(
                  dimension: 48,
                  child: Icon(FontAwesomeIcons.google, color: AppColors.red),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                child: const SizedBox.square(
                  dimension: 48,
                  child: Icon(
                    FontAwesomeIcons.apple,
                    color: AppColors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
