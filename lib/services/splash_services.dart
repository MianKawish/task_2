import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_2/bloc/splash/bloc/bloc/splash_bloc.dart';

class SplashServices {
  static decider(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      context.read<SplashBloc>().add(LoginStatusEvent());
    });
  }
}
