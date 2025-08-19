import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:routine/extensions/context_extension.dart';
import 'package:routine/extensions/num_extension.dart';
import 'package:routine/dimensions/app_dimens.dart';
import 'package:routine/theme/app_colors.dart';

class InputField extends StatefulWidget {
  const InputField({
    super.key,
    this.prefixIcon,
    this.readOnly = false,
    this.surfixIcon,
    this.hint,
    this.maxLines,
    this.validator,
    this.onTap,
    this.enabled = true,
    this.initialValue,
    this.inputFormatters = const [],
    this.textColor,
    this.fontWeight,
    this.keyboardType,
    this.obscureText = false,
    this.controller,
    this.useErrorBorder = false,
    this.textAlign,
    this.letterSpacing,
    this.borderRadius,
    this.useFocusBorder = false,
    this.label,
    this.height,
    this.minLines,
    this.filled = false,
    this.fillColor,
    this.focusNode,
    this.borderColor,
    this.onChange,
  });

  final String? hint;
  final String? initialValue;
  final int? maxLines;
  final bool filled;
  final Color? fillColor;
  final int? minLines;
  final double? height;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextEditingController? controller;
  final double? letterSpacing;
  final bool useFocusBorder;
  final List<TextInputFormatter> inputFormatters;
  final void Function(String)? onChange;
  final Widget? prefixIcon;
  final Color? textColor;
  final Color? borderColor;
  final Widget? surfixIcon;
  final FocusNode? focusNode;
  final bool useErrorBorder;
  final double? borderRadius;
  final String? label;
  final bool readOnly;
  final TextAlign? textAlign;
  final VoidCallback? onTap;
  final FontWeight? fontWeight;
  final String? Function(String?)? validator;

  final bool enabled;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  String _value = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label ?? '',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          5.height,
        ],
        TextFormField(
          style: TextStyle(
            letterSpacing: 0,
            fontSize: 14,
            fontWeight: widget.fontWeight,
          ),
          maxLines: widget.maxLines,
          enabled: widget.enabled,
          minLines: widget.minLines,
          controller: widget.controller,
          focusNode: widget.focusNode,
          initialValue: widget.initialValue,
          validator: widget.validator,
          readOnly: widget.readOnly,
          onTap: widget.enabled ? widget.onTap : null,
          onChanged: (value) {
            setState(() => _value = value);
            widget.onChange?.call(value);
          },
          obscureText: widget.obscureText,
          obscuringCharacter: '*',
          inputFormatters: widget.inputFormatters,
          textAlign: widget.textAlign ?? TextAlign.start,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.surfixIcon,
            errorStyle: const TextStyle(
              color: AppColors.redDark,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            hintStyle: TextStyle(
              color: context.isDarkMode ? AppColors.greyC8 : AppColors.grey55,
              fontSize: 14,
              letterSpacing: 0,
              fontWeight: FontWeight.w400,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                widget.borderRadius ?? Dimens.defaultBorderRadius,
              ),
              borderSide: BorderSide(
                color: context.isDarkMode ? AppColors.greyC8 : AppColors.grey37,
                width: 1,
              ),
            ),
            constraints: BoxConstraints(minHeight: 44),
            contentPadding: const EdgeInsets.only(
              top: 12,
              bottom: 12,
              left: 20,
              right: 12,
            ),
            hintText: widget.hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                widget.borderRadius ?? Dimens.defaultBorderRadius,
              ),
              borderSide: BorderSide(
                      color: context.isDarkMode
                          ? AppColors.grey55
                          : AppColors.greyC8,
                      width: 1,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
