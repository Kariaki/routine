import 'package:flutter/cupertino.dart';
import 'package:routine/core/extensions/context_extension.dart';
import 'package:routine/core/extensions/num_extension.dart';
import 'package:routine/app/auth/presentation/screens/select_what_you_want_to_track.dart';
import 'package:routine/src/widgets/app_button.dart';
import 'package:routine/src/widgets/default_text_input_field.dart';
import 'package:routine/app/auth/presentation/components/onboarding_scaffold.dart';
import 'package:routine/app/auth/presentation/components/option_card_component.dart';

class PersonalizeYourJourneyScreen extends StatefulWidget {
  const PersonalizeYourJourneyScreen({super.key});

  @override
  State<PersonalizeYourJourneyScreen> createState() =>
      _PersonalizeYourJourneyScreenState();
}

class _PersonalizeYourJourneyScreenState
    extends State<PersonalizeYourJourneyScreen> {
  String? _selectedProductivity;
  String? _selectedHealthAndFitness;
  String? _selectedSelfCarAndMindfulness;

  String? selected;

  @override
  Widget build(BuildContext context) {
    final titles = [
      'Founder',
      'Working Professional',
      'Student',
      'Freelancer',
      'Home-maker',
      'Other',
    ];
    return OnboardingScaffold(
      title: 'Let’s personalize your \njourney.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputField(label: 'Name', hint: 'Enter your name'),
          40.height,
          Text('Daily routine type', style: context.textTheme.headlineMedium),
          20.height,
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: titles.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8
            ),
            itemBuilder: (_, index) {
              return OptionCardComponent(
                title: titles[index],
                selected: selected == titles[index],
                onClick: () {
                  setState(() {
                    selected = titles[index];
                  });
                },
              );
            },
          ),
          50.height,
          AppButton.primary(
            text: 'Done',
            enable:
                _selectedSelfCarAndMindfulness != null &&
                _selectedHealthAndFitness != null &&
                _selectedProductivity != null,
            onPressed: () {
              context.push(SelectWhatYouWantToTrack());
            },
          ),
          100.height
        ],
      ),
    );
  }
}
