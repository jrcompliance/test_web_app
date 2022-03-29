import 'package:flutter/cupertino.dart';
import 'package:test_web_app/Models/GetInvoiceModel.dart';

class GetInvoiceListProvider extends ChangeNotifier{
  List<GetInvoiceModel> _invoicemodellist = [];
  List<GetInvoiceModel> get invoicemodellist
}