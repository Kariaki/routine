import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:routine/core/extensions/context_extension.dart';
import 'package:routine/core/extensions/num_extension.dart';
import 'package:routine/core/dimensions/app_dimens.dart';
import 'package:routine/src/theme/app_colors.dart';

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
    this.decoration,
    this.textStyle,
    this.onSubmit,
    this.onChange,
    this.inputAction
  });

  final String? hint;
  final String? initialValue;
  final int? maxLines;
  final TextStyle? textStyle;
  final bool filled;
  final Color? fillColor;
  final int? minLines;
  final TextInputAction? inputAction;
  final double? height;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextEditingController? controller;
  final double? letterSpacing;
  final bool useFocusBorder;
  final List<TextInputFormatter> inputFormatters;
  final void Function(String)? onChange;
  final void Function(String)? onSubmit;
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
  final InputDecoration? decoration;
  final VoidCallback? onTap;
  final FontWeight? fontWeight;
  final String? Function(String?)? validator;

  final bool enabled;

  factory InputField.borderLess({
    String? hintText,
    TextStyle? hintTextStyle,
    TextEditingController? controller,
    TextStyle? textStyle,
    void Function(String)? onSubmit,
    void Function(String)? onChanged,

  }) {
    return InputField(
      textStyle: textStyle,
      inputAction: TextInputAction.done,
      onSubmit: onSubmit,
      onChange: onChanged,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText??'Title',
        hintStyle: hintTextStyle,

        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    );
  }

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
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          5.height,
        ],
        TextFormField(
          style:
              widget.textStyle ??
              TextStyle(
                letterSpacing: 0,
                fontSize: 14,
                fontWeight: widget.fontWeight,
              ),
          maxLines: widget.maxLines,
          enabled: widget.enabled,
          minLines: widget.minLines,
          controller: widget.controller,
          focusNode: widget.focusNode,
          textInputAction: widget.inputAction,
          initialValue: widget.initialValue,
          onFieldSubmitted: widget.onSubmit,
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
          decoration:
              widget.decoration ??
              InputDecoration(
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.surfixIcon,
                errorStyle: const TextStyle(
                  color: AppColors.redDark,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                hintStyle: TextStyle(
                  color: context.isDarkMode
                      ? AppColors.greyC8
                      : AppColors.grey55,
                  fontSize: 14,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w400,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? Dimens.defaultBorderRadius,
                  ),
                  borderSide: BorderSide(
                    color: context.isDarkMode
                        ? AppColors.greyC8
                        : AppColors.grey37,
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
                enabledBorder: OutlineInputBorder(
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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? Dimens.defaultBorderRadius,
                  ),
                  borderSide: BorderSide(
                    color: context.isDarkMode
                        ? AppColors.grey55
                        : AppColors.greyC8.withValues(alpha: .2),
                    width: 1,
                  ),
                ),
              ),
        ),
      ],
    );
  }
}
