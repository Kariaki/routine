import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:routine/core/extensions/context_extension.dart';
import 'package:routine/src/theme/app_colors.dart';

class OptionPillComponent extends StatelessWidget {
  const OptionPillComponent({
    super.key,
    this.onClick,
    this.selected = false,
    required this.title,
  });

  final bool selected;

  final String title;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      radius: 100,
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
        decoration: ShapeDecoration(
          color: context.isDarkMode
              ? (selected ? AppColors.grey37 : Colors.transparent)
              : (selected ? AppColors.greyE8 : Colors.transparent),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
            side: !selected
                ? BorderSide(
                    width: 1,
                    color: context.isDarkMode
                        ? AppColors.grey55
                        : AppColors.greyC8,
                  )
                : BorderSide.none,
          ),
        ),
        child: Text(
          title,
          style: context.textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
