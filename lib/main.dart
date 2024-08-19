import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_2/bloc/home/bloc/home_bloc.dart';
import 'package:task_2/bloc/login/bloc/login_bloc.dart';
import 'package:task_2/bloc/signup/bloc/signup_bloc.dart';
import 'package:task_2/bloc/splash/bloc/bloc/splash_bloc.dart';
import 'package:task_2/firebase_options.dart';
import 'package:task_2/repos/auth_repo/auth_repo.dart';
import 'package:task_2/screens/signup/signup_screen.dart';
import 'package:task_2/screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SignupBloc(AuthRepo()),
          ),
          BlocProvider(
            create: (context) => SplashBloc(AuthRepo()),
          ),
          BlocProvider(
            create: (context) => LoginBloc(AuthRepo()),
          ),
          BlocProvider(
            create: (context) => HomeBloc(AuthRepo()),
          )
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ));
  }
}
