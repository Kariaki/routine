import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:routine/extensions/context_extension.dart';
import 'package:routine/extensions/num_extension.dart';
import 'package:routine/dimensions/app_dimens.dart';
import 'package:routine/theme/app_colors.dart';

class AppButton extends StatelessWidget {
  const AppButton._({
    this.onPressed,
    this.text,
    this.textColor,
    this.child,
    this.removeBorder = false,
    this.width,
    this.height,
    this.loading = false,
    this.textStyle,
    this.icon,
    this.enabled = true,
    this.borderColor,
    this.color,
  });

  final VoidCallback? onPressed;
  final Widget? child;

  final Color? textColor;
  final String? text;

  final double? height;
  final Color? borderColor;
  final Widget? icon;
  final double? width;
  final bool enabled;
  final bool removeBorder;
  final Color? color;
  final TextStyle? textStyle;

  final bool loading;

  factory AppButton.primary({
    String? text,
    Widget? child,
    double? height,
    Widget? icon,
    bool loading = false,
    VoidCallback? onPressed,
    bool ignoreFamily = false,
    bool enable = true,
  }) => AppButton._(
    enabled: enable,

    loading: loading,
    height: height,
    removeBorder: true,
    icon: icon,
    onPressed:onPressed,
    text: text,
  );

  factory AppButton.outline({
    String? text,
    Widget? child,
    double? height,
    Widget? icon,
    Color? borderColor,
    bool loading = false,
    Color? textColor,
    VoidCallback? onPressed,
    bool ignoreFamily = false,
  }) => AppButton._(
    color: Colors.transparent,
    textColor: textColor ?? AppColors.primaryLight,
    loading: loading,
    height: height,

    removeBorder: false,
    icon: icon,
    borderColor: borderColor,
    onPressed: onPressed,
    text: text,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed:!enabled?null: () {
        if (loading || onPressed == null) {
          return;
        }
        HapticFeedback.lightImpact();
        FocusScope.of(context).unfocus();
        onPressed?.call();
      },
      height: height ?? Dimens.buttonHeight,
      minWidth: width ?? double.infinity,
      disabledColor: (context.isDarkMode ? AppColors.grey22 : AppColors.greyC8),
      elevation: 0,
      focusElevation: 0,
      highlightElevation: 0,

      padding: const EdgeInsets.symmetric(vertical: Dimens.buttonPadding),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(1000),
        borderSide: removeBorder
            ? BorderSide.none
            : BorderSide(color: borderColor ?? AppColors.buttonPrimary),
      ),
      color:
          color ??
          (context.isDarkMode ? AppColors.primaryLight : AppColors.primaryDark),
      enableFeedback: true,
      child:
          child ??
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (icon != null) ...[icon!, 10.width],
              Text(
                text ?? '',
                style:
                    textStyle ??
                    TextStyle(
                      color:
                          textColor ??
                          (context.isDarkMode
                              ? AppColors.black
                              : AppColors.white),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
              ),
              if (loading) ...[
                10.width,
                const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ],
          ),
    );
  }
}
