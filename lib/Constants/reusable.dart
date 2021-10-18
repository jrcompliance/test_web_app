import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);
const txtColor = Colors.white;
const grClr = Colors.grey;
const defaultPadding = 16.0;

// clr for headers
const clsClr = Color(0xFFF44336);
const wonClr = Color(0xFF4CAF50);
const flwClr = Color(0xFFf9A825);
const ipClr = Color(0xFF039BE5);
const prosClr = Color(0xFF9C27B0);
const neClr = Color(0xFFFF6E40);

const conClr = Color(0xFF3D5AFE);
const irrClr = Color(0xFFFF7043);

const avgClr = Color(0xFF64B5F6);
const goodClr = Color(0xFF4DB6AC);

const folClr = Color(0xFFFF5722);
const spClr = Color(0xFFF06292);
const qtoClr = Color(0xFF616161);

class TxtStls {
  static const stl1 =
      TextStyle(color: Clrs.txtColor, fontWeight: FontWeight.w200);
  static const stl2 =
      TextStyle(color: Clrs.bgColor, fontWeight: FontWeight.w100);
  static const stl3 = TextStyle(color: grClr);
  static const stl4 = TextStyle(color: grClr, fontSize: 10);
  static const hdstl = TextStyle(
      color: Clrs.txtColor, fontSize: 17, fontWeight: FontWeight.w900);
  static const stl11 =
      TextStyle(color: Clrs.txtColor, fontWeight: FontWeight.w700);
  static const stl122 = TextStyle(
      color: Clrs.bgColor,
      fontWeight: FontWeight.w100,
      fontSize: 10.0,
      overflow: TextOverflow.ellipsis);
}

class Clrs {
  static const appBarColor = Colors.brown;
  static const bgColor = Colors.black;
  static const txtColor = Colors.white;
  static const urgent = Colors.red;
  static const high = Colors.yellowAccent;
  static const normal = Colors.lightBlueAccent;
  static const low = Colors.lightGreen;
}

class statClr {
  static const todo = Colors.indigo;
  static const inpro = Colors.orange;
  static const ready = Colors.red;
  static const com = Colors.green;
}
