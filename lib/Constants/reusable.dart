import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

const bgColor = Colors.white;
const AbgColor = Colors.grey;
const txtColor = Colors.black;
const fieldColor = Color(0x8AEEEEEE);
const btnColor = Color(0xFF5551F1);
const bt = Colors.indigoAccent;
const ibgclr = Color(0xFFB71C1C);
const bluColor = Colors.blueAccent;
bool isloggedIn = false;
var logoutTime;

const deco = BoxDecoration(
  color: fieldColor,
  borderRadius: BorderRadius.all(Radius.circular(5.0)),
);
const deco2 = BoxDecoration(
  color: fieldColor,
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
);

class TxtStls {
  static const titlestyle = TextStyle(fontSize: 30, color: txtColor);
  static TextStyle fieldtitlestyle = GoogleFonts.nunito(
      textStyle:
          TextStyle(fontSize: 13, color: txtColor, fontWeight: FontWeight.bold),
      fontSize: 13,
      color: txtColor,
      fontWeight: FontWeight.bold);
  static TextStyle fieldtitlestyle3 = GoogleFonts.nunito(
      textStyle:
          TextStyle(fontSize: 13, color: AbgColor, fontWeight: FontWeight.bold),
      fontSize: 13,
      color: AbgColor,
      fontWeight: FontWeight.bold);
  static TextStyle fieldBtnStyle = GoogleFonts.nunito(
      textStyle:
          TextStyle(fontSize: 20, color: btnColor, fontWeight: FontWeight.bold),
      fontSize: 20,
      color: btnColor,
      fontWeight: FontWeight.bold);
  static TextStyle titlesstyle = GoogleFonts.nunito(
      textStyle:
          TextStyle(fontSize: 13, color: bgColor, fontWeight: FontWeight.bold),
      fontSize: 13,
      color: bgColor,
      fontWeight: FontWeight.bold);
  static TextStyle titlesstyle10 = GoogleFonts.nunito(
      textStyle:
          TextStyle(fontSize: 8, color: bgColor, fontWeight: FontWeight.bold),
      fontSize: 8,
      color: bgColor,
      fontWeight: FontWeight.bold);
  static TextStyle titlestyle14 = GoogleFonts.nunito(
      textStyle:
          TextStyle(fontSize: 13, color: btnColor, fontWeight: FontWeight.bold),
      fontSize: 13,
      color: btnColor,
      fontWeight: FontWeight.bold);
  static TextStyle titlestyle15 = GoogleFonts.nunito(
      textStyle:
          TextStyle(fontSize: 13, color: bluColor, fontWeight: FontWeight.bold),
      fontSize: 13,
      color: bluColor,
      fontWeight: FontWeight.bold);
  static TextStyle fieldtitlestylelarge = GoogleFonts.alata(
      textStyle:
          TextStyle(fontSize: 25, color: txtColor, fontWeight: FontWeight.bold),
      fontSize: 25,
      color: txtColor,
      fontWeight: FontWeight.bold);
  static TextStyle fieldtitlestylelarge2 = GoogleFonts.alata(
      textStyle:
          TextStyle(fontSize: 20, color: txtColor, fontWeight: FontWeight.bold),
      fontSize: 20,
      color: txtColor,
      fontWeight: FontWeight.bold);
  static TextStyle fieldtitlestyle11 = GoogleFonts.nunito(
      textStyle:
          TextStyle(fontSize: 20, color: txtColor, fontWeight: FontWeight.bold),
      fontSize: 20,
      color: txtColor,
      fontWeight: FontWeight.bold);
  static TextStyle notestyle = GoogleFonts.nunito(
      textStyle: TextStyle(fontSize: 13, color: txtColor),
      fontSize: 13,
      color: txtColor);
  static const fieldtitlestyle1 =
      TextStyle(fontSize: 13, color: txtColor, fontStyle: FontStyle.italic);
  static const fieldtitlestyle2 =
      TextStyle(fontSize: 12, color: txtColor, fontWeight: FontWeight.bold);
  static TextStyle fieldstyle = GoogleFonts.nunito(
      textStyle: TextStyle(color: txtColor, fontSize: 12.5, letterSpacing: 0.2),
      color: txtColor,
      letterSpacing: 0.2,
      fontSize: 12.5);
  static TextStyle fieldstyle22 = GoogleFonts.nunito(
    textStyle: TextStyle(color: txtColor, fontSize: 15, letterSpacing: 0.2),
    color: txtColor,
    letterSpacing: 0.2,
    fontSize: 15,
  );
  static TextStyle fieldstyle222 = GoogleFonts.nunito(
      textStyle: TextStyle(color: txtColor, fontSize: 12.5, letterSpacing: 0.2),
      color: txtColor,
      letterSpacing: 0.2,
      fontSize: 12.5,
      fontWeight: FontWeight.bold);
  static TextStyle fieldstyle22bold = GoogleFonts.nunito(
      textStyle: TextStyle(color: txtColor, fontSize: 15, letterSpacing: 0.2),
      color: txtColor,
      letterSpacing: 0.2,
      fontSize: 15,
      fontWeight: FontWeight.bold);
  static TextStyle fieldstatusstyle = GoogleFonts.nunito(
      textStyle: TextStyle(color: wonClr, fontSize: 12.5, letterSpacing: 0.2),
      color: wonClr,
      letterSpacing: 0.2,
      fontSize: 12.5);
  static TextStyle messagestyle = GoogleFonts.nunito(
      textStyle: TextStyle(color: bgColor, fontSize: 12.5, letterSpacing: 0.2),
      color: bgColor,
      letterSpacing: 0.2,
      fontSize: 12.5);
  static TextStyle fieldstyle111 = GoogleFonts.nunito(
      textStyle: TextStyle(color: bt, fontSize: 12.5, letterSpacing: 0.2),
      color: bt,
      letterSpacing: 0.2,
      fontSize: 12.5);
  static const btnstyle = TextStyle(color: btnColor, fontSize: 12.5);
  static const numstyle =
      TextStyle(color: txtColor, fontSize: 20, fontWeight: FontWeight.bold);
  static TextStyle fieldstyle1 = GoogleFonts.nunito(
      textStyle: TextStyle(color: bgColor, fontSize: 12.5, letterSpacing: 0.2),
      color: bgColor,
      letterSpacing: 0.2,
      fontSize: 12.5);
  static TextStyle fieldstyle11 = GoogleFonts.nunito(
      textStyle: TextStyle(color: bgColor, fontSize: 12.5, letterSpacing: 0.2),
      color: bgColor,
      letterSpacing: 0.1,
      fontSize: 12);

  static const stl1 = TextStyle(color: bt, fontWeight: FontWeight.w200);
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

class ClrStls {
  static TextStyle tnClr = GoogleFonts.nunito(
      fontSize: 12, color: btnColor, fontWeight: FontWeight.bold);
  static TextStyle endClr = GoogleFonts.nunito(
      fontSize: 12, color: neClr, fontWeight: FontWeight.bold);
  static TextStyle errorstyle = GoogleFonts.nunito(
      textStyle:
          TextStyle(fontSize: 12, color: clsClr, fontWeight: FontWeight.bold),
      fontSize: 12,
      color: clsClr,
      fontWeight: FontWeight.bold);
}

const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const grClr = Colors.grey;
const defaultPadding = 16.0;
const kTileHeight = 50.0;
const inProgressColor = Colors.black87;
const todoColor = Color(0xffd1d2d7);

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

class Clrs {
  static const appBarColor = Colors.brown;
  static const bgColor = Colors.black;
  static const txtColor = Colors.white;
  static const urgent = Colors.red;
  static const yellowClr = Colors.yellow;
  static const high = Colors.yellowAccent;
  static const normal = Colors.lightBlueAccent;
  static const low = Colors.lightGreen;
}

class statClr {
  static const todo = Colors.indigo;
  static const inpro = Colors.orange;
  static const ready = Colors.red;
  static const com = Colors.green;
  static const com1 = Colors.indigoAccent;
}

class toastmessage {
  static sucesstoast(BuildContext context, e) {
    Size size = MediaQuery.of(context).size;
    MotionToast.success(
      toastDuration: Duration(seconds: 2),
      title: Text("Success", style: TxtStls.fieldtitlestyle),
      description: Text(e, style: TxtStls.fieldstyle),
      width: size.width * 0.25,
      animationType: ANIMATION.fromRight,
      position: MOTION_TOAST_POSITION.top,
    ).show(context);
  }

  static warningmessage(BuildContext context, e) {
    Size size = MediaQuery.of(context).size;
    MotionToast.warning(
      toastDuration: Duration(seconds: 2),
      title: Text("Warning", style: TxtStls.fieldtitlestyle),
      description: Text(e.toString(), style: TxtStls.fieldstyle),
      width: size.width * 0.25,
      animationType: ANIMATION.fromRight,
      position: MOTION_TOAST_POSITION.top,
    ).show(context);
  }
}
