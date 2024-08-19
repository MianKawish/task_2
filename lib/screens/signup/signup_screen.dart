import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_2/bloc/signup/bloc/signup_bloc.dart';
import 'package:task_2/extensions/string_extension.dart';
import 'package:task_2/res/appStrings/appStrings.dart';
import 'package:task_2/screens/home/home_screen.dart';
import 'package:task_2/screens/login/login_screen.dart';
import 'package:task_2/utils/utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                  Appstrings.signupText,
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
                              .read<SignupBloc>()
                              .add(FirstNameChangedEvent(value)),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 3) {
                              return Appstrings.nameErrorText;
                            } else {
                              return null;
                            }
                          },
                          decoration:
                              textFieldDecoration(Appstrings.firstNameHintText),
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        TextFormField(
                          onChanged: (value) => context
                              .read<SignupBloc>()
                              .add(LastNameChangedEvent(value)),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 3) {
                              return Appstrings.nameErrorText;
                            } else {
                              return null;
                            }
                          },
                          decoration:
                              textFieldDecoration(Appstrings.lastNameHintText),
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        TextFormField(
                          onChanged: (value) => context
                              .read<SignupBloc>()
                              .add(EmailChangedEvent(value)),
                          validator: (value) {
                            if (value != null && value.isValidEmail) {
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
                              .read<SignupBloc>()
                              .add(PasswordChangedEvent(value)),
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
                BlocListener<SignupBloc, SignupState>(
                  listener: (context, state) {
                    if (state.status == FormStatus.success) {
                      Utils.flutterToast("User created successfully");
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ));
                    }
                    if (state.status == FormStatus.error) {
                      Utils.flutterToast(state.errMsg.toString());
                    }
                  },
                  child: BlocBuilder<SignupBloc, SignupState>(
                    builder: (context, state) {
                      return ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.blue)),
                          onPressed: state.status == FormStatus.loading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    context
                                        .read<SignupBloc>()
                                        .add(FormSubmitEvent());
                                  }
                                },
                          child: state.status == FormStatus.loading
                              ? const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : const Text(
                                  Appstrings.signupText,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ));
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(Appstrings.accountLoginHintText),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ));
                        },
                        child: const Text(
                          Appstrings.loginText,
                          style: TextStyle(
                              fontStyle: FontStyle.italic, color: Colors.blue),
                        ))
                  ],
                )
              ],
            )));
  }
}

InputDecoration textFieldDecoration(String title) {
  return InputDecoration(
    hintText: title,
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.blue, width: 1.5)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.blue, width: 1.5)),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.blue, width: 1.5)),
  );
}
