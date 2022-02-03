import 'package:flutter/material.dart';
import 'package:test_web_app/Constants/Services.dart';
import 'package:test_web_app/Constants/reusable.dart';

class MyCalenders {
  static pickEndDate(BuildContext context, _endDateController) {
    showDatePicker(
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            primarySwatch: Colors.grey,
            splashColor: Colors.black,
            textTheme: TextTheme(
              subtitle1: TextStyle(color: Colors.black),
              button: TextStyle(color: Colors.black),
            ),
            accentColor: Colors.black,
            colorScheme: ColorScheme.light(
                primary: btnColor,
                primaryVariant: Colors.black,
                secondaryVariant: Colors.black,
                onSecondary: Colors.black,
                onPrimary: Colors.white,
                surface: Colors.black,
                onSurface: Colors.black,
                secondary: Colors.black),
            dialogBackgroundColor: Colors.white,
          ),
          child: child ?? Text(""),
        );
      },
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    ).then((value) {
      _endDateController.text = value!.toString().split(" ")[0];
    });
  }

  static pickEndDate1(BuildContext context, id, _endDateController) {
    showDatePicker(
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData(
                  primarySwatch: Colors.grey,
                  splashColor: Colors.black,
                  textTheme: TextTheme(
                    subtitle1: TextStyle(color: Colors.black),
                    button: TextStyle(color: Colors.black),
                  ),
                  accentColor: Colors.black,
                  colorScheme: ColorScheme.light(
                      primary: btnColor,
                      primaryVariant: Colors.black,
                      secondaryVariant: Colors.black,
                      onSecondary: Colors.black,
                      onPrimary: Colors.white,
                      surface: Colors.black,
                      onSurface: Colors.black,
                      secondary: Colors.black),
                  dialogBackgroundColor: Colors.white,
                ),
                child: child ?? Text(""),
              );
            },
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100))
        .then((value) {
      _endDateController.text = value!.toString().split(" ")[0];

      EndDateOperations.updateEdateTask(id, _endDateController);
    });
  }

  static pickEndDate2(BuildContext context, _endDateController1) {
    showDatePicker(
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData(
                  primarySwatch: Colors.grey,
                  splashColor: Colors.black,
                  textTheme: TextTheme(
                    subtitle1: TextStyle(color: Colors.black),
                    button: TextStyle(color: Colors.black),
                  ),
                  accentColor: Colors.black,
                  colorScheme: ColorScheme.light(
                      primary: btnColor,
                      primaryVariant: Colors.black,
                      secondaryVariant: Colors.black,
                      onSecondary: Colors.black,
                      onPrimary: Colors.white,
                      surface: Colors.black,
                      onSurface: Colors.black,
                      secondary: Colors.black),
                  dialogBackgroundColor: Colors.white,
                ),
                child: child ?? Text(""),
              );
            },
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100))
        .then((value) {
      _endDateController1.text = value!.toString().split(" ")[0];
    });
  }
}
