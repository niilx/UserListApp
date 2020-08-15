import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ProjectResource{

  static String baseUrl = "https://reqres.in";
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double bodyFontSize = 0.0;
  static double headerFontSize = 0.0;

  static BuildContext currentContext;
  static void setScreenSize(BuildContext context) {
    if(ModalRoute.of(context).isCurrent) {
      currentContext = context;
    }

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    screenHeight = screenWidth < screenHeight
        ? screenHeight
        : (screenWidth / screenHeight) * screenWidth;
    bodyFontSize = screenWidth*0.035;
    headerFontSize = screenWidth*0.04;
  }



  static showToast(String text, bool isError, String gravity,) {
    Color textColor = Colors.white;
    Color backColor = Colors.green;

    if (isError) {
      textColor = Colors.white;
      backColor = Colors.red;
    }
    if (gravity == "top") {
      Toast.show(text, currentContext,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
          backgroundColor: backColor,
          textColor: textColor);
    } else if (gravity == "center") {
      Toast.show(text, currentContext,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.CENTER,
        backgroundColor: backColor,
        textColor: textColor,
      );
    } else {
      Toast.show(text, currentContext,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: backColor,
          textColor: textColor);
    }
  }
}