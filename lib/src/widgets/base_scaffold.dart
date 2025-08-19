import 'package:flutter/material.dart';
import 'package:routine/core/extensions/context_extension.dart';
import 'package:routine/core/dimensions/app_dimens.dart';
import 'package:routine/src/theme/app_colors.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    super.key,
    this.appBar,
    required this.child,
    this.padding,
    this.scaffoldKey,
  });

  final PreferredSizeWidget? appBar;
  final Widget child;
  final double? padding;

  final GlobalKey<ScaffoldState>? scaffoldKey;

  factory BaseScaffold.withAppBar(
    BuildContext context, {
    String? title,
    List<Widget>? actions,
    double? height,
    Color? backgroundColor,
    double? padding,
    GlobalKey<ScaffoldState>? key,
    Widget? leading,
    Widget? titleWidget,
    Widget? drawer,
    bool ignoreAppBar = false,
    bool loading = false,
    bool showBackButton = true,
    required Widget child,
  }) {
    return BaseScaffold(
      appBar: ignoreAppBar
          ? null
          : AppBar(
              leading: showBackButton
                  ? BackButton(
                      color: context.isDarkMode
                          ? AppColors.white
                          : AppColors.black,
                    )
                  : null,
              actions: actions,
              automaticallyImplyLeading: false,
            ),
      padding: padding,
      scaffoldKey: key,

      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: appBar,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal:padding?? Dimens.pagePadding),
          child: child,
        ),
      ),
    );
  }
}
