import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static void flutterToast(String text) {
    Fluttertoast.showToast(
      msg: text,
      backgroundColor: Colors.red,
      fontSize: 22,
      gravity: ToastGravity.TOP,
      textColor: Colors.black,
    );
  }
}
