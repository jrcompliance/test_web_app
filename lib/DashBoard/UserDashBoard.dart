import 'package:flutter/material.dart';
import 'package:test_web_app/Constants/Responsive.dart';
import 'package:test_web_app/Constants/reusable.dart';

class UserDashBoard extends StatefulWidget {
  const UserDashBoard({Key? key}) : super(key: key);

  @override
  _UserDashBoardState createState() => _UserDashBoardState();
}

class _UserDashBoardState extends State<UserDashBoard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: AbgColor.withOpacity(0.075),
      width: size.width,
      height: size.height * 0.93,
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                alignment: Alignment.center,
                width: Responsive.isMediumScreen(context)
                    ? size.width * 0.18
                    : size.width * 0.195,
                height: size.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      maxRadius: 30.0,
                      child: Image.asset("assets/Logos/4.png"),
                      backgroundColor: Colors.blueAccent.withOpacity(0.1),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("178+", style: TxtStls.numstyle),
                        Text("Prospect", style: TxtStls.fieldstyle)
                      ],
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                alignment: Alignment.center,
                width: Responsive.isMediumScreen(context)
                    ? size.width * 0.18
                    : size.width * 0.195,
                height: size.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      maxRadius: 30.0,
                      child: Image.asset("assets/Logos/1.png"),
                      backgroundColor: Colors.orangeAccent.withOpacity(0.1),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("20+", style: TxtStls.numstyle),
                        Text("NewLeads", style: TxtStls.fieldstyle)
                      ],
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                alignment: Alignment.center,
                width: Responsive.isMediumScreen(context)
                    ? size.width * 0.18
                    : size.width * 0.195,
                height: size.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      maxRadius: 30.0,
                      child: Center(
                        child: Image.asset("assets/Logos/2.png",
                            fit: BoxFit.fill,
                            filterQuality: FilterQuality.high),
                      ),
                      backgroundColor: Colors.yellowAccent.withOpacity(0.1),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("198+", style: TxtStls.numstyle),
                        Text("InProgress", style: TxtStls.fieldstyle)
                      ],
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                alignment: Alignment.center,
                width: Responsive.isMediumScreen(context)
                    ? size.width * 0.18
                    : size.width * 0.195,
                height: size.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      maxRadius: 30.0,
                      child: Image.asset("assets/Logos/3.png",
                          fit: BoxFit.fill, filterQuality: FilterQuality.high),
                      backgroundColor: btnColor.withOpacity(0.1),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("12+", style: TxtStls.numstyle),
                        Text("Won", style: TxtStls.fieldstyle)
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.04),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  alignment: Alignment.center,
                  width: Responsive.isMediumScreen(context)
                      ? size.width * 0.48
                      : size.width * 0.5,
                  height: size.height * 0.3,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Reports", style: TxtStls.fieldtitlestyle),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.more_horiz_rounded)),
                          ],
                        ),
                      )
                    ],
                  )),
              Container(
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  alignment: Alignment.center,
                  width: Responsive.isMediumScreen(context)
                      ? size.width * 0.28
                      : size.width * 0.3,
                  height: size.height * 0.3,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Analytics", style: TxtStls.fieldtitlestyle),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.more_horiz_rounded)),
                          ],
                        ),
                      )
                    ],
                  )),
            ],
          ),
          SizedBox(height: size.height * 0.04),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                alignment: Alignment.center,
                width: size.width * 0.25,
                height: size.height * 0.1,
                child: Text("PI -Amount", style: TxtStls.numstyle),
              ),
              Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                alignment: Alignment.center,
                width: size.width * 0.25,
                height: size.height * 0.1,
                child: Text("Q -Amount", style: TxtStls.numstyle),
              ),
              Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                alignment: Alignment.center,
                width: size.width * 0.25,
                height: size.height * 0.1,
                child: Text("Invoice -Amount", style: TxtStls.numstyle),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.04),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  alignment: Alignment.center,
                  width: Responsive.isMediumScreen(context)
                      ? size.width * 0.48
                      : size.width * 0.5,
                  height: size.height * 0.3,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Recent Interactions",
                                style: TxtStls.fieldtitlestyle),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.more_horiz_rounded)),
                          ],
                        ),
                      )
                    ],
                  )),
              Container(
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  alignment: Alignment.center,
                  width: Responsive.isMediumScreen(context)
                      ? size.width * 0.28
                      : size.width * 0.3,
                  height: size.height * 0.3,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Today Duelist",
                                style: TxtStls.fieldtitlestyle),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.more_horiz_rounded)),
                          ],
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
