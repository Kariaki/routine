import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:routine/core/extensions/context_extension.dart';
import 'package:routine/core/extensions/num_extension.dart';
import '../../../core/asset/app_assets.dart';

class HomeEmptyState extends StatelessWidget {
  const HomeEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 40),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SvgPicture.asset(AppAsset.homeEmptyState),
        40.height,
        Text('Start Your Journey', style: context.textTheme.titleLarge),
        20.height,
        Text(
          'Every big step start with small step. Note your first idea and start your journey!',
          style: context.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        20.height,
        Align(
          alignment: Alignment.centerRight,
          child: Padding(padding: EdgeInsets.only(right: 20),
          child: SvgPicture.asset(AppAsset.arrow),),
        ),
        20.height
      ],
    ),);
  }
}
