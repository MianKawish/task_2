import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_2/bloc/login/bloc/login_bloc.dart';
import 'package:task_2/res/appStrings/appStrings.dart';
import 'package:task_2/screens/home/home_screen.dart';
import 'package:task_2/screens/signup/signup_screen.dart';
import 'package:task_2/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.05, horizontal: width * 0.05),
            child: ListView(
              children: [
                const Text(
                  Appstrings.loginText,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          onChanged: (value) => context
                              .read<LoginBloc>()
                              .add(EmailChangedInLoginEvent(value)),
                          validator: (value) {
                            if (value!.contains("@") &&
                                value.endsWith(".com")) {
                              return null;
                            } else {
                              return Appstrings.emailErrorText;
                            }
                          },
                          decoration:
                              textFieldDecoration(Appstrings.hintEmailText),
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        TextFormField(
                          onChanged: (value) => context
                              .read<LoginBloc>()
                              .add(PasswordChangedInLoginEvent(value)),
                          obscureText: true,
                          validator: (value) {
                            if (value!.length < 8 || value.isEmpty) {
                              return Appstrings.passwordErrorText;
                            } else {
                              return null;
                            }
                          },
                          decoration:
                              textFieldDecoration(Appstrings.hintPasswordText),
                        )
                      ],
                    )),
                SizedBox(
                  height: height * 0.1,
                ),
                BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state.loginStatus == LoginStatus.success) {
                      Utils.flutterToast("Logged in Successfully");
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ));
                    }
                  },
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.blue)),
                        onPressed: state.loginStatus == LoginStatus.loading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context
                                      .read<LoginBloc>()
                                      .add(LoginButtonEvent());
                                }
                              },
                        child: state.loginStatus == LoginStatus.loading
                            ? const Center(
                                child: SizedBox(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : const Text(
                                Appstrings.loginButtonText,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(Appstrings.accountSignupHintText),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignupScreen(),
                              ));
                        },
                        child: const Text(
                          Appstrings.signupText,
                          style: TextStyle(
                              fontStyle: FontStyle.italic, color: Colors.blue),
                        ))
                  ],
                )
              ],
            )));
  }
}
