import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routine/core/extensions/context_extension.dart';
import 'package:routine/core/extensions/num_extension.dart';
import 'package:routine/app/auth/presentation/screens/sign_in_screen.dart';

import 'package:routine/core/asset/app_assets.dart';
import 'package:routine/src/widgets/app_button.dart';
import 'package:routine/src/widgets/base_scaffold.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(AppAsset.landingPageAsset),
              40.height,
              Text(
                'Welcome to ',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
              ),
              5.height,
              Text(
                'Routine.',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: context.colorScheme.primary,
                ),
              ),
            ],
          ),
          175.height,
          AppButton.primary(
            text: "Let’s Get Started",
            onPressed: (){
              context.pushReplace(SignInScreen());
            },
          )
        ],
      ),
    );
  }
}
