import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_2/bloc/home/bloc/home_bloc.dart';
import 'package:task_2/bloc/signup/bloc/signup_bloc.dart';
import 'package:task_2/res/appStrings/appStrings.dart';
import 'package:task_2/screens/login/login_screen.dart';
import 'package:task_2/screens/signup/signup_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;

  userFieldIntializer() {
    context.read<HomeBloc>().add(InsertDataToFieldsEvent());
  }

  @override
  void initState() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    userFieldIntializer();
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          Appstrings.homeText,
          style: TextStyle(
              color: Colors.blue, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          BlocListener<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state.status == FormStatus.userLogout) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ));
              }
            },
            child: IconButton(
                onPressed: _showMyDialog,
                icon: const Icon(
                  Icons.logout_rounded,
                  color: Colors.red,
                )),
          )
        ],
      ),
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (_firstNameController.text != state.firstName) {
            _firstNameController.text = state.firstName;
          }
          if (_lastNameController.text != state.lastName) {
            _lastNameController.text = state.lastName;
          }
        },
        child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.05, horizontal: width * 0.05),
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return ListView(
                  children: [
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _firstNameController,
                              enabled: state.isEnabled,
                              onChanged: (value) {
                                context
                                    .read<HomeBloc>()
                                    .add(FirstNameChangedInHomeEvent(value));
                              },
                              validator: (value) {
                                if (value!.isEmpty || value.length < 3) {
                                  return Appstrings.nameErrorText;
                                } else {
                                  return null;
                                }
                              },
                              decoration:
                                  textFieldDecoration("Enter your first name"),
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            TextFormField(
                              controller: _lastNameController,
                              enabled: state.isEnabled,
                              onChanged: (value) => context
                                  .read<HomeBloc>()
                                  .add(LastNameChangedInHomeEvent(value)),
                              validator: (value) {
                                if (value!.isEmpty || value.length < 3) {
                                  return Appstrings.nameErrorText;
                                } else {
                                  return null;
                                }
                              },
                              decoration:
                                  textFieldDecoration("Enter your last name"),
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            TextFormField(
                              enabled: false,
                              decoration: textFieldDecoration(state.email),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: height * 0.1,
                    ),
                    state.isEnabled
                        ? ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.blue)),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context
                                    .read<HomeBloc>()
                                    .add(UpdateUserDataEvent());
                              }
                            },
                            child: const Text(
                              Appstrings.doneText,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ))
                        : ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.blue)),
                            onPressed: () {
                              print("Before ${state.isEnabled}");
                              context.read<HomeBloc>().add(FieldChangerEvent());
                              print("After ${state.isEnabled}");
                            },
                            child: const Text(
                              Appstrings.editText,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ))
                  ],
                );
              },
            )),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(Appstrings.logoutChoiceText),
          actions: [
            TextButton(
              child: const Text(Appstrings.yesText),
              onPressed: () {
                Navigator.of(context).pop();
                //implement logout login here
                context.read<HomeBloc>().add(LogoutUserEvent());
              },
            ),
            TextButton(
              child: const Text(Appstrings.noText),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
