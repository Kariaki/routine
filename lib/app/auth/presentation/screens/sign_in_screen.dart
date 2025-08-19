import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:routine/app/auth/presentation/cubit/auth_cubit.dart';
import 'package:routine/app/auth/presentation/screens/register_screen.dart';
import 'package:routine/app/root/app_root.dart';
import 'package:routine/core/extensions/context_extension.dart';
import 'package:routine/core/extensions/num_extension.dart';

import '../../../../core/util/cubit_state.dart';
import '../../../../src/widgets/app_button.dart';
import '../../../../src/widgets/default_text_input_field.dart';
import '../../data/dto/user_dto.dart';
import '../../domain/entity/login_entity.dart';
import '../components/continue_with_component.dart';
import '../components/onboarding_scaffold.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      title: 'Let’s Sign you in',

      showBack: false,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputField(
              controller: _emailController,
              hint: 'Enter your email address',
              label: 'Email address',
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Required';
                }

                return null;
              },
            ),
            SizedBox(height: 15),
            InputField(
              controller: _passwordController,
              obscureText: true,
              maxLines: 1,
              hint: '************',
              label: 'Password',
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Required';
                }
                if (value!.length < 6) {
                  return 'Password Must be at least 6 characters';
                }
                return null;
              },
            ),
            5.height,
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot Password',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            50.height,
            BlocConsumer<AuthCubit, BaseState<UserModel>>(
              builder: (_, state) {
                return AppButton.primary(
                  text: 'Sign In',
                  loading: state.isLoading,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final loginEntity = LoginEntity(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      context.read<AuthCubit>().login(loginEntity);
                    }
                  },
                );
              },
              listener: (_, state) {
                if (state.isError) {
                  Fluttertoast.showToast(
                    msg: state.error ?? 'Something went wrong',
                  );
                }
                if (state.isSuccess) {
                  // context.pushRemoveUntil(AppRootScreen());
                }
              },
            ),
            50.height,
            ContinueWithComponent(
              description: 'Don’t have an account? ',
              actionText: 'Register here.',
              onActionPressed: (){
                context.pushReplace(RegisterScreen());
              },
            ),
            100.height,
          ],
        ),
      ),
    );
  }
}
