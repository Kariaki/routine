import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:routine/extensions/context_extension.dart';

import '../theme/app_colors.dart';

class OptionCardComponent extends StatelessWidget {
  const OptionCardComponent({
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
      onTap: onClick,
      borderRadius: BorderRadius.circular(16),
      radius: 16,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: context.isDarkMode
              ? (selected ? AppColors.grey37 : Colors.transparent)
              : (selected ? AppColors.greyE8 : Colors.transparent),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
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
        child: Text(title, style: context.textTheme.bodyLarge,
        textAlign: TextAlign.center,),
      ),
    );
  }
}
