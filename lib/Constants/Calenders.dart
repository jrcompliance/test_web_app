import 'package:flutter/material.dart';
import 'package:test_web_app/Constants/Services.dart';

class MyCalenders {
  static pickEndDate(BuildContext context, _endDateController) {
    showDatePicker(
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
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100))
        .then((value) {
      _endDateController1.text = value!.toString().split(" ")[0];
    });
  }
}
