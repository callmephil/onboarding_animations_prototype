import 'dart:async';

import 'package:app/extensions/object_extensions.dart';
import 'package:app/theme/app_colors.dart';
import 'package:app/theme/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class UploadField extends StatelessWidget {
  const UploadField({super.key, this.onTap, this.label = 'Upload a file'});

  final FutureOr<void> Function()? onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.s160,
      width: double.infinity,
      child: Ink(
        decoration: BoxDecoration(
          color: onTap.isNull
              ? AppColors.black.withValues(alpha: .10)
              : AppColors.surface,
          borderRadius: AppSizes.borderRadius4,
          border: DashedBorder.fromBorderSide(
            dashLength: 12,
            side: BorderSide(
              color: (onTap.isNull
                      ? Theme.of(context)
                          .inputDecorationTheme
                          .disabledBorder
                          ?.borderSide
                          .color
                      : Theme.of(context)
                          .inputDecorationTheme
                          .enabledBorder
                          ?.borderSide
                          .color) ??
                  AppColors.black.withValues(alpha: .25),
            ),
          ),
        ),
        child: InkWell(
          splashColor: AppColors.black.withValues(alpha: 0.25),
          borderRadius: AppSizes.borderRadius4,
          onTap: onTap,
          child: Center(
            child: Column(
              spacing: AppSizes.s8,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.upload_file_outlined),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
