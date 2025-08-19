import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routine/app/auth/presentation/cubit/auth_cubit.dart';
import 'package:routine/app/auth/presentation/screens/sign_in_screen.dart';
import 'package:routine/core/extensions/context_extension.dart';
import 'package:routine/core/extensions/num_extension.dart';
import '../../../core/util/cubit_state.dart';
import '../../../src/theme/app_colors.dart';
import '../../../src/widgets/base_scaffold.dart';
import '../../auth/data/dto/user_dto.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(),
      padding: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<AuthCubit, BaseState<UserModel>>(
            builder: (_, state) {
              if (!state.isSuccess) {
                return SizedBox();
              }
              final account = state.data;
              if (account != null) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      account.fullname,
                      style: context.textTheme.headlineMedium,
                    ),
                    10.height,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.email,
                          size: 16,
                          color: context.isDarkMode
                              ? AppColors.greyC8
                              : AppColors.grey55,
                        ),
                        5.width,
                        Text(
                          account.email,
                          style: context.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: context.isDarkMode
                                ? AppColors.greyC8
                                : AppColors.grey55,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
              return SizedBox();
            },
          ),
          10.height,
          Divider(
            color: context.isDarkMode ? AppColors.greyC8 : AppColors.grey55,
            thickness: .2,
          ),
          20.height,
          GestureDetector(
            onTap: () {
              context.read<AuthCubit>().logout();
              context.pushRemoveUntil(SignInScreen());
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.logout, color: AppColors.redDark),
                5.width,
                Text(
                  'Logout',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.redDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
