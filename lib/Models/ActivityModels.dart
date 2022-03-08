import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityModel {
  final String action;
  final String bound;
  final String from;
  final String to;
  final String who;
  final String lastdate;
  final bool yes;
  final String qdate;
  final Timestamp when;
  final String note;

  ActivityModel(
      {required this.action,
      required this.bound,
      required this.from,
      required this.to,
      required this.who,
      required this.lastdate,
      required this.yes,
      required this.qdate,
      required this.when,
      required this.note});
}
