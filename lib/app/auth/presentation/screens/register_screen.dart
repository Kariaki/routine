import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:routine/app/auth/presentation/screens/personalize_your_journey_screen.dart';
import 'package:routine/app/auth/presentation/cubit/auth_cubit.dart';
import 'package:routine/app/auth/domain/entity/create_account_dto.dart';
import 'package:routine/core/extensions/context_extension.dart';
import 'package:routine/core/extensions/num_extension.dart';
import 'package:routine/app/auth/presentation/screens/sign_in_screen.dart';
import 'package:routine/core/util/cubit_state.dart';
import 'package:routine/src/widgets/app_button.dart';
import 'package:routine/src/widgets/default_text_input_field.dart';
import 'package:routine/app/auth/data/dto/user_dto.dart';
import 'package:routine/app/auth/presentation/components/continue_with_component.dart';
import 'package:routine/app/auth/presentation/components/onboarding_scaffold.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      title: 'Register',
      showBack: false,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputField(
              label: 'Full Name',
              hint: 'Enter your name',
              controller: _nameController,
            ),
            20.height,
            InputField(
              label: 'Email Address',
              hint: 'Example: johndoe@gmail.com',
              controller: _emailController,
            ),
            20.height,
            InputField(
              label: 'Password',
              hint: '********',
              maxLines: 1,
              controller: _passwordController,
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
            20.height,
            InputField(
              label: 'Re-enter Password',
              hint: '*********',
              maxLines: 1,
              controller: _confirmPasswordController,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Required';
                }
                if (value != _passwordController.text) {
                  return 'Password does not match';
                }
                return null;
              },
            ),

            50.height,
            BlocConsumer<AuthCubit, BaseState<UserModel>>(
              builder: (_, state) {
                return AppButton.primary(
                  text: 'Register',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final registerEntity = CreateAccountEntity(
                        fullname: _nameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      context.read<AuthCubit>().createAccount(registerEntity);
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
                  context.pushRemoveUntil(PersonalizeYourJourneyScreen());
                }
              },
            ),
            50.height,
            ContinueWithComponent(
              description: 'Already have an account? ',
              actionText: 'Sign In here.',
              onActionPressed: () {
                context.pushReplace(SignInScreen());
              },
            ),
            100.height,
          ],
        ),
      ),
    );
  }
}
