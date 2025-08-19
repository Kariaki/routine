import 'package:flutter/cupertino.dart';
import 'package:routine/core/extensions/context_extension.dart';
import 'package:routine/core/extensions/num_extension.dart';
import 'package:routine/app/root/app_root.dart';

import 'package:routine/src/widgets/app_button.dart';
import 'package:routine/app/auth/presentation/components/onboarding_scaffold.dart';
import 'package:routine/app/auth/presentation/components/selectable_component.dart';

class SelectWhatYouWantToTrack extends StatefulWidget {
  const SelectWhatYouWantToTrack({super.key});

  @override
  State<SelectWhatYouWantToTrack> createState() =>
      _SelectWhatYouWantToTrackState();
}

class _SelectWhatYouWantToTrackState extends State<SelectWhatYouWantToTrack> {
  String? _selectedProductivity;
  String? _selectedHealthAndFitness;
  String? _selectedSelfCarAndMindfulness;

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      title: 'What do you want to track?',
      child: Column(
        children: [
          SelectableComponent(
            title: 'Productivity',
            onChanged: (value) {
              setState(() {
                _selectedProductivity = value;
              });
            },
            options: ['Work', 'Study', 'Side Hustle', 'Other'],
          ),
          40.height,
          SelectableComponent(
            title: 'Health & Fitness',
            onChanged: (value) {
              setState(() {
                _selectedHealthAndFitness = value;
              });
            },
            options: [
              'Excercise',
              'Sleep',
              'Diet',
              'Sports',
              'Water Intake',
              'Other',
            ],
          ),
          40.height,

          SelectableComponent(
            title: 'Self-car & Mindfulness',
            onChanged: (value) {
              setState(() {
                _selectedSelfCarAndMindfulness = value;
              });
            },
            options: [
              'Journaling',
              'Reading',
              'Meditation',
              'Skin-care',
              'Other',
            ],
          ),
          40.height,
          AppButton.primary(
            text: 'Done',
            enable:
                _selectedSelfCarAndMindfulness != null &&
                _selectedHealthAndFitness != null &&
                _selectedProductivity != null,
            onPressed: () {
              context.pushRemoveUntil(AppRootScreen());
            },
          ),
        ],
      ),
    );
  }
}
