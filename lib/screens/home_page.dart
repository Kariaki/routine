import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routine/components/option_card_component.dart';
import 'package:routine/components/option_pill_component.dart';
import 'package:routine/constants/app_constants.dart';
import 'package:routine/cubit/auth_cubit.dart';
import 'package:routine/di/injectable.dart';
import 'package:routine/dto/user_dto.dart';
import 'package:routine/entity/create_note_entity.dart';
import 'package:routine/extensions/num_extension.dart';
import 'package:routine/repositories/note_repository.dart';
import 'package:routine/util/cubit_state.dart';
import 'package:routine/widgets/app_button.dart';
import 'package:routine/widgets/base_scaffold.dart';
import 'package:routine/widgets/default_text_input_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _repo = getIt.get<NoteRepository>(
    instanceName: DependencyNames.firebase.name,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String? selectedTitle;

  bool checked = false;

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
    return BaseScaffold(
      child: BlocBuilder<AuthCubit, BaseState<UserModel>>(
        builder: (_, state) {
          final account = state.data;
          if (account == null) {
            return SizedBox();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: titles
                    .map(
                      (e) => OptionPillComponent(
                        title: e,
                        selected: selectedTitle == e,
                        onClick: () => setState(() {
                          selectedTitle = e;
                        }),
                      ),
                    )
                    .toList(),
              ),
              40.height,
              AppButton.primary(enable: false, text: 'Done'),
              40.height,
              Checkbox(
                value: checked,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                visualDensity: VisualDensity.compact,

                onChanged: (value) => setState(() {
                  checked = value??false;
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
