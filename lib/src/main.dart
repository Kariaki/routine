import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:routine/app/root/splash_screen.dart';
import 'package:routine/src/theme/app_theme.dart';
import '../app/auth/presentation/cubit/auth_cubit.dart';
import '../app/note/presentation/cubit/note_cubit.dart';
import '../core/util/app_config.dart';
import 'di/injectable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: AppConfig.firebaseOptions);
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<NoteCubit>(create: (context) => NoteCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        home: AppSplashScreen(),
      ),
    );
  }
}
