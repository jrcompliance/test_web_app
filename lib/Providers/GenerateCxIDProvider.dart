import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class RecentFetchCXIDProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int? CxID;
  int? eid;
  int? inid;
  String? actualinid;
  int? leadId;
  int? creditid;
  int? isiserviceid;
  int? debitid;
  int? deliveryid;

  int? cashmemoid;
  Future<void> fetchRecent() async {
    try {
      await _firestore
          .collection("GenerateId's")
          .doc("CxID")
          .update({"CxID": FieldValue.increment(1)}).then((value) async {
        await _firestore
            .collection("GenerateId's")
            .doc("CxID")
            .get()
            .then((value) {
          CxID = value.get("CxID");
          notifyListeners();
        });
      });
      notifyListeners();
    } on Exception catch (e, s) {
      print("${s}" + "${e.toString()}");
    }
  }

  Future<void> fetchRecentemployeeid() async {
    try {
      await _firestore
          .collection("GenerateId's")
          .doc("EmployeeId")
          .update({"eid": FieldValue.increment(1)}).then((value) async {
        await _firestore
            .collection("GenerateId's")
            .doc("EmployeeId")
            .get()
            .then((value) {
          eid = value.get("eid");
          notifyListeners();
        });
      });
      notifyListeners();
    } on Exception catch (e, s) {
      print("${s}" + "${e.toString()}");
    }
  }

  Future<void> fetchRecentInvoiceid() async {
    try {
      await _firestore
          .collection("GenerateId's")
          .doc("InvoiceId")
          .update({"inid": FieldValue.increment(1)}).then((value) async {
        await _firestore
            .collection("GenerateId's")
            .doc("InvoiceId")
            .get()
            .then((value) {
          inid = value.get("inid");
          notifyListeners();
        });
      }).then((value) => generateInvoice(inid));
      notifyListeners();
    } on Exception catch (e, s) {
      print("${s}" + "${e.toString()}");
    }
  }

  Future generateInvoice(val) async {
    var month = DateFormat("MM").format(DateTime.now());
    var year = DateFormat("yy").format(DateTime.now());
    int mymonth = int.parse(month);
    int myyear = int.parse(year);
    int acyear = myyear;
    int acyear1 = myyear;
    if (mymonth <= 3) {
      acyear = myyear - 1;
      notifyListeners();
    } else {
      acyear1 = myyear + 1;
      notifyListeners();
    }
    show() {
      if (mymonth <= 9) {
        return 0;
      } else {
        return null;
      }
    }

    // print("Added value is : " + addval.toString());
    String storeval = show().toString() +
        mymonth.toString() +
        acyear.toString() +
        acyear1.toString() +
        val.toString();
    actualinid = storeval;
    print(actualinid);
    notifyListeners();
  }

  Future<void> fetchcreditID() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    _firestore
        .collection("GenerateId's")
        .doc("creditID")
        .update({"creditid": FieldValue.increment(1)}).then((value) async {
      await _firestore
          .collection("GenerateId's")
          .doc("creditID")
          .get()
          .then((value) {
        creditid = value.get("creditid");
      });
      print("creditid--" + creditid.toString());
      notifyListeners();
    });
  }

  Future<void> fetchDebitID() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    _firestore
        .collection("GenerateId's")
        .doc("debitID")
        .update({"debitid": FieldValue.increment(1)}).then((value) async {
      await _firestore
          .collection("GenerateId's")
          .doc("debitID")
          .get()
          .then((value) {
        creditid = value.get("debitid");
      });
      print("debitid--" + debitid.toString());
      notifyListeners();
    });
  }

  Future<void> fetchDeliveryID() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    _firestore
        .collection("GenerateId's")
        .doc("DeliveryID")
        .update({"deliveryid": FieldValue.increment(1)}).then((value) async {
      await _firestore
          .collection("GenerateId's")
          .doc("DeliveryID")
          .get()
          .then((value) {
        deliveryid = value.get("deliveryid");
      });
      print("deliveryid--" + deliveryid.toString());
      notifyListeners();
    });
  }

  Future<void> fetchCashMemoID() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    _firestore
        .collection("GenerateId's")
        .doc("CashMemoID")
        .update({"cashmemoid": FieldValue.increment(1)}).then((value) async {
      await _firestore
          .collection("GenerateId's")
          .doc("CashMemoID")
          .get()
          .then((value) {
        cashmemoid = value.get("cashmemoid");
      });
      print("cashmemoid--" + cashmemoid.toString());
      notifyListeners();
    });
  }

  Future<void> fetchLeadId() async {
    try {
      await _firestore
          .collection("GenerateId's")
          .doc("LeadID")
          .update({"leadId": FieldValue.increment(1)}).then((value) async {
        await _firestore
            .collection("GenerateId's")
            .doc("LeadID")
            .get()
            .then((value) {
          leadId = value.get("leadId");
          notifyListeners();
        });
      });
      notifyListeners();
    } on Exception catch (e, s) {
      print("${s}" + "${e.toString()}");
    }
  }

  Future<void> fetchServiceId() async {
    try {
      await _firestore.collection("GenerateId's").doc("ISIServiceId").update(
          {"isiserviceid": FieldValue.increment(1)}).then((value) async {
        await _firestore
            .collection("GenerateId's")
            .doc("ISIServiceId")
            .get()
            .then((value) {
          isiserviceid = value.get("isiserviceid");
          notifyListeners();
        });
      });
      notifyListeners();
    } on Exception catch (e, s) {
      print("${s}" + "${e.toString()}");
    }
  }
}
