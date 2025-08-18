import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routine/entity/create_account_dto.dart';
import 'package:routine/cubit/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Enter your email address',
                labelText: 'Email address',
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter your email address',
                labelText: 'Email address',
              ),
            ),
            SizedBox(height: 15),
            MaterialButton(
              color: Colors.black,
              onPressed: () {
                context.read<AuthCubit>().createAccount(
                  CreateAccountEntity(
                    fullname: 'Ebilate Kariaki',
                    email: 'kariaki.ebilate@gmail.com',
                    password: 'password',
                  ),
                );
              },
              child: Text('Login', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
