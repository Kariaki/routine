import 'package:flutter/material.dart';
import 'package:routine/core/extensions/context_extension.dart';
import 'package:routine/app/auth/presentation/screens/landing_page.dart';
import '../../src/di/injectable.dart';
import '../../src/service/secured_storage_service.dart';
import 'app_root.dart';

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
      body: Container(),
    );
  }

  void _loadApp() async {
    final isLoggedIn = await getIt<SecureStorageService>().isLoggedIn();

    Future.delayed(const Duration(seconds: 3), () {
      context.pushRemoveUntil(isLoggedIn ? const AppRootScreen() : LandingPage());
    });
  }
}
