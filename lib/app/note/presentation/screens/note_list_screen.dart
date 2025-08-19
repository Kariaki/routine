import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routine/app/root/components/home_empty_state.dart';
import 'package:routine/app/note/presentation/components/note_item_component.dart';
import 'package:routine/app/auth/presentation/cubit/auth_cubit.dart';
import 'package:routine/app/note/presentation/cubit/note_cubit.dart';
import 'package:routine/app/note/data/dto/note_dto.dart';
import 'package:routine/core/extensions/context_extension.dart';
import 'package:routine/core/extensions/num_extension.dart';

import '../../../../core/asset/app_assets.dart';
import '../../../../core/util/cubit_state.dart';
import '../../../../src/theme/app_colors.dart';
import '../../../../src/widgets/base_scaffold.dart';
import '../../../auth/data/dto/user_dto.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  @override
  void initState() {
    super.initState();
  }

  String? selectedTitle;

  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: BlocBuilder<NoteCubit, BaseState<List<NoteDto>>>(
        builder: (_, state) {
          final notes = state.data ?? [];
          if (notes.isEmpty) {
            return HomeEmptyState();
          }
          return Column(
            children: [
              70.height,
              Container(
                width: double.infinity,
                height: 104,
                padding: EdgeInsets.all(20),
                decoration: ShapeDecoration(
                  color: context.isDarkMode
                      ? AppColors.grey37
                      : AppColors.greyE8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: BlocBuilder<AuthCubit, BaseState<UserModel>>(
                        builder: (_, authCubitState) {
                          final account = authCubitState.data;
                          if (account == null) {
                            return SizedBox();
                          }
                          final firstName =
                              account.fullname.split(' ').firstOrNull ?? '';
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                firstName,
                                style: context.textTheme.titleLarge,
                              ),
                              10.height,
                              Text(
                                "You have successfully finished 2 lists.",
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: context.isDarkMode
                                      ? AppColors.greyC8
                                      : AppColors.grey55,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    10.width,
                    SvgPicture.asset(AppAsset.homeWelcomeImage),
                  ],
                ),
              ),
              20.height,

              GridView.builder(
                padding: EdgeInsets.all(0),
                physics: NeverScrollableScrollPhysics(),
                itemCount: notes.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .7,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (_, index) {
                  return NoteItemComponent(note: notes[index]);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
