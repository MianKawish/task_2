import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_2/bloc/splash/bloc/bloc/splash_bloc.dart';
import 'package:task_2/res/assets/imageAssets.dart';
import 'package:task_2/screens/home/home_screen.dart';
import 'package:task_2/screens/signup/signup_screen.dart';
import 'package:task_2/services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashScreen> {
  @override
  void initState() {
    SplashServices.decider(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state.isLoggedIn) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ));
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SignupScreen(),
                ));
          }
        },
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage(Images.splashImage))),
        ),
      ),
    );
  }
}
