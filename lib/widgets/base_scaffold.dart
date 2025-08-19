import 'package:flutter/material.dart';
import 'package:routine/dimensions/app_dimens.dart';

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

  factory BaseScaffold.withAppBar({
    String? title,
    List<Widget>? actions,
    double? height,
    Color? backgroundColor,
    double? padding,
    GlobalKey<ScaffoldState>? key,
    Widget? leading,
    Widget? titleWidget,
    Widget? drawer,
    bool loading = false,
    bool showBackButton = true,
    required Widget child,
  }) {
    return BaseScaffold(
      appBar: AppBar(
        leading: showBackButton ? BackButton() : null,
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
        body: Padding(padding: EdgeInsets.symmetric(horizontal: Dimens.pagePadding), child: child),
      ),
    );
  }
}
