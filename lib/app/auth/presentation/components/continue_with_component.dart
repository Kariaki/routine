import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:routine/core/extensions/context_extension.dart';
import 'package:routine/core/extensions/num_extension.dart';

import '../../../../core/asset/app_assets.dart';
import '../../../../src/theme/app_colors.dart';
import '../../../../src/widgets/app_button.dart';
class ContinueWithComponent extends StatelessWidget {
  const ContinueWithComponent({
    super.key,
    required this.description,
    required this.actionText,
    required this.onActionPressed,
  });

  final String description;
  final String actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Divider(
                color: context.isDarkMode ? AppColors.grey55 : AppColors.greyC8,
              ),
            ),
            10.width,
            Text(
              'Or continue with',
              style: context.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.grey7D,
              ),
            ),
            10.width,
            Expanded(
              child: Divider(
                color: context.isDarkMode ? AppColors.grey55 : AppColors.greyC8,
              ),
            ),
          ],
        ),
        20.height,
        Row(
          children: [
            Expanded(
              child: AppButton.outline(
                borderColor: context.isDarkMode
                    ? AppColors.grey55
                    : AppColors.grey95,
                textColor: context.colorScheme.onSurface,
                icon: SvgPicture.asset(AppAsset.facebook),
                text: 'Facebook',
              ),
            ),
            20.width,

            Expanded(
              child: AppButton.outline(
                borderColor: context.isDarkMode
                    ? AppColors.grey55
                    : AppColors.grey95,
                textColor: context.colorScheme.onSurface,
                icon: SvgPicture.asset(AppAsset.google),
                text: 'Google',
              ),
            ),
          ],
        ),
        20.height,
        Text.rich(
          TextSpan(
            text: description,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.isDarkMode?AppColors.grey55:AppColors.greyC8,
                fontWeight: FontWeight.w500
            ),
            children: [
              TextSpan(
                text: ' $actionText',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.w500
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = (){
                    onActionPressed?.call();
                  }
              ),
            ],
          ),
        ),
      ],
    );
  }
}
