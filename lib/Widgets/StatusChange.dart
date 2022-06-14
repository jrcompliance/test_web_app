import 'package:flutter/material.dart';
import 'package:status_change/status_change.dart';
import 'package:test_web_app/Constants/reusable.dart';

class HorizontalExample extends StatefulWidget {
  @override
  _HorizontalExampleState createState() => _HorizontalExampleState();
}

class _HorizontalExampleState extends State<HorizontalExample> {
  int _processIndex = 0;

  Color getColor(int index) {
    if (index == _processIndex) {
      return inProgressColor;
    } else if (index < _processIndex) {
      return Colors.green;
    } else {
      return todoColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            child: StatusChange.tileBuilder(
              theme: StatusChangeThemeData(
                direction: Axis.horizontal,
                connectorTheme: ConnectorThemeData(space: 1.0, thickness: 1.0),
              ),
              builder: StatusChangeTileBuilder.connected(
                itemWidth: (_) =>
                    MediaQuery.of(context).size.width / _processes.length,
                contentWidgetBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'add content here',
                      style: TextStyle(
                        color: Colors
                            .blue, // change color with dynamic color --> can find it with example section
                      ),
                    ),
                  );
                },
                nameWidgetBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'your text ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: getColor(index),
                      ),
                    ),
                  );
                },
                indicatorWidgetBuilder: (_, index) {
                  if (index <= _processIndex) {
                    return DotIndicator(
                      size: 35.0,
                      border: Border.all(color: Colors.green, width: 1),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return OutlinedDotIndicator(
                      size: 30,
                      borderWidth: 1.0,
                      color: todoColor,
                    );
                  }
                },
                lineWidgetBuilder: (index) {
                  if (index > 0) {
                    if (index == _processIndex) {
                      final prevColor = getColor(index - 1);
                      final color = getColor(index);
                      var gradientColors;
                      gradientColors = [
                        prevColor,
                        Color.lerp(prevColor, color, 0.5)
                      ];
                      return DecoratedLineConnector(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: gradientColors,
                          ),
                        ),
                      );
                    } else {
                      return SolidLineConnector(
                        color: getColor(index),
                      );
                    }
                  } else {
                    return null;
                  }
                },
                itemCount: _processes.length,
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.skip_next),
          onPressed: () {
            print(_processIndex);
            setState(() {
              _processIndex++;

              if (_processIndex == 7) {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => FinishView()));
              }
            });
          },
        ),
      ],
    );
  }
}

final _processes = [
  'Order Signed',
  'Order Processed',
  'Shipped ',
  'Out for delivery ',
  'Delivered ',
];

// final _content = [
//   '20/18',
//   '20/18',
//   '20/18',
//   '20/18',
//   '20/18',
// ];
