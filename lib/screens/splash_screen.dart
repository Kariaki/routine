import 'package:flutter/material.dart';
import 'package:routine/extensions/context_extension.dart';
import 'package:routine/screens/login_screen.dart';
import 'package:routine/di/injectable.dart';
import 'package:routine/service/secured_storage_service.dart';
import 'home_page.dart';

class AppSplashScreen extends StatefulWidget {
  const AppSplashScreen({super.key});

  @override
  State<AppSplashScreen> createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadApp();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('Welcome to my app')],
      ),
    );
  }

  void _loadApp() async {
    final isLoggedIn = await getIt<SecureStorageService>().isLoggedIn();

    Future.delayed(const Duration(seconds: 3), () {
      context.pushRemoveUntil(isLoggedIn ? const HomePage() : LoginScreen());
    });
  }
}
