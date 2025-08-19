import 'package:flutter/cupertino.dart';
import 'package:routine/core/extensions/context_extension.dart';
import 'package:routine/core/extensions/num_extension.dart';
import 'package:routine/src/widgets/base_scaffold.dart';

class OnboardingScaffold extends StatelessWidget {
  const OnboardingScaffold({
    super.key,
    this.showBack = true,
    this.title,
    required this.child,
    this.ignoreAppBar=false
  });

  final bool showBack;
  final String? title;
  final bool ignoreAppBar;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold.withAppBar(
      context,
      padding: 20,
      showBackButton: showBack,
      ignoreAppBar: ignoreAppBar,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            20.height,
            Text(title ?? '', style: context.textTheme.titleLarge),
            50.height,
          ],
          Expanded(
            child: SingleChildScrollView(
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
