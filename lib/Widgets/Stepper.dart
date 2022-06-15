import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';

class MyStepper extends StatefulWidget {
  @override
  _MyStepper createState() => _MyStepper();
}

class _MyStepper extends State<MyStepper> {
  // THE FOLLOWING TWO VARIABLES ARE REQUIRED TO CONTROL THE STEPPER.
  int activeStep = 1;
  int upperBound = 6;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [nextButton()],
          // )
        ],
      ),
    );
  }

  // Returns the next button.
  Widget nextButton() {
    return ElevatedButton(
      onPressed: () {
        // Increment activeStep, when the next button is tapped. However, check for upper bound.
        if (activeStep < upperBound) {
          setState(() {
            activeStep++;
          });
        }
      },
      child: Text('Next'),
    );
  }

  /// Returns the header wrapping the header text.
  Widget header() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              headerText(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Returns the header text based on the activeStep.
  String headerText() {
    switch (activeStep) {
      case 1:
        return 'Preface';

      case 2:
        return 'Table of Contents';

      case 3:
        return 'About the Author';

      case 4:
        return 'Publisher Information';

      case 5:
        return 'Reviews';

      case 6:
        return 'Chapters #1';

      default:
        return 'Introduction';
    }
  }
}
