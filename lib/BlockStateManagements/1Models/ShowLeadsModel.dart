import 'package:cloud_firestore/cloud_firestore.dart';

class ShowLeadsModel {
  final String? leadid;
  final String? leadname;
  final String? leadCxId;
  final String? leadcat;
  final String? leadcompanymname;
  final String? leadendDate;
  final String? leadfail;
  final String? leadsuccess;
  final bool? leadflag;
  final Timestamp? leadlastseen;
  final String? leadmessage;
  final String? leadlogo;
  final String? leadpriority;
  final String? leadqdate;
  final Timestamp? leadtime;
  final String? website;

  ShowLeadsModel(
      {this.leadid,
      this.leadname,
      this.leadCxId,
      this.leadcat,
      this.leadcompanymname,
      this.leadendDate,
      this.leadfail,
      this.leadflag,
      this.website,
      this.leadlastseen,
      this.leadlogo,
      this.leadmessage,
      this.leadpriority,
      this.leadqdate,
      this.leadsuccess,
      this.leadtime});
}
