import 'package:cloud_firestore/cloud_firestore.dart';

class LeadUpdateModel {
  String? From;
  String? To;
  String? Who;
  Timestamp? When;
  String? Note;
  String? LatDate;
  bool? Yes;
  String? Bound;
  String? Action;
  String? queryDate;

  LeadUpdateModel(
      {this.From,
      this.To,
      this.Who,
      this.When,
      this.Note,
      this.LatDate,
      this.Yes,
      this.Bound,
      this.Action,
      this.queryDate});

  toMap() {
    return {
      "From": From,
      "To": To,
      "Who": Who,
      "When": When,
      "Note": Note,
      "LatDate": LatDate,
      "Yes": Yes,
      "Bound": Bound,
      "Action": Action,
      "queryDate": queryDate,
    };
  }
}
