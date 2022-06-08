import 'package:gsheets/gsheets.dart';
import 'package:test_web_app/GoogleSheets/DataFields.dart';

class GSheetsApi {
  static const credentials = r'''
  {
  "type": "service_account",
  "project_id": "jrcrm-4f580",
  "private_key_id": "b5f788b794054c30a44780124e0bc34dd3e0ed10",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCFlXhorcVYWRrB\nXOcCmz4BZ3tyiAkJleOgmYJYU8cNtDzdsoN07C47cIeFwBcsr+RozNCbXR52Q1dJ\nZtGW82D0DyW/q5pMEyDgvg7ux5Li9BQdsu2HPs4/d24ZgK7311UgGOFMqBhFFi8v\nR5fgISPvba3nhZ3qyrz6egpOZX9N1rYOHIcYDGf0AQfE2Wva4AgZbDXy6FMgVEcB\nUi8HP8Xn/eSW7lkHChykaqs9lGg5UXL2a06mW+Hxv8o+0IG6XMT5Tvpdh0b38rfT\n2NyPhXYKtJibOJlbZX5whw2UHVdNoATueFkrAm0Bz8dW3VYzSJ+WFGOHJE2hy0Bk\n+cQVPTKnAgMBAAECggEADx6RfU+bFC/UTmnEdSVltDpRMkUMDiYFQzUnbUs2Lr/l\nWmENGJvEHn19vqQKO3LrvaIzmOdw6N51r7IlK2+qhpUm/EsLm2wC1E0kBYoDKbrf\nLVQGJxZIY83nC+3mX9jjIqSOQ43htALEc8Enrc+Hxglk8zJ1YuYa05gijdMBFf8l\nx/+elJ1T+oNjZtC3W7dB09ZE0i8cFA4SmGt0x7HRpidXVfE4IbFFtvsBVh/4WbtG\nDAA9tiEobQFLINtxqZNrN3vZUtL7pjkRwwg46jQWymUy+Yij19UiJKJEGzMgkVH2\nEEK7vCn2A2NfCGVsK2O+U77VQWE+mhtqalVeZZO4iQKBgQC79HqlECA6CIyokYmg\nqMo4pkuHHe5sUWfnY67LbnDLO2iKMuwtkSemBWWh2aI2bBafTarDPj+lPphV89Sw\n8PszKA94/TLdtqDJNr9SXFaH22kdIiRtiJgI/Xsgrp/qVdx28Acqx7KlYqBkswGT\nMRAFL1xGwaJ+jrW/Q+/uGhGoEwKBgQC18esBfIred3U54r6hIiRvr8YWtaQ4xOL2\nt1kZs3our1sx1DwIXVgRH6IgEmrswMirB2Laln/MEcMB9dV0X7DCXi6fwiBxRDG7\nlAAm9nEUOTYy0o8o36RVJHuR3yeXIFT8wkhpM0UHY2h//raeXPrNMqVw9mHRE1wH\ngVW8zPRFnQKBgQCWOYBxP6NSXxT1gmVrCJ2gi6GgXBb9ck9GzRCfPiVe+pvCoZLN\nlNAIzRV/ODCDqP6n0u7iYHWEQLSHNnzP87wDFkjPnigyt05ppJ1kWbM7oO2xwGE3\nPs6tmNP5ujjMllXApnZEBhrOPzcNZVmj6LnyOvlZAFk9KBkxxz4Uo7drCwKBgDFX\newD7MnnkcZESMdpm9PSo+ZJ9Dh0rH9YCoRI8Px1cBuI7iVBHaDO0nXYPKJouKf1f\n0movOFcyVe05KvsVXE1J12ER91RgRxB0sZnfaYkvfshHm/VcuScx7qT/nK/6X7Hw\nSkzlT4oSZmuXuxS1aHqvinhZCOv3URTj+UlrV69tAoGAY/Zk8n3MrncIHEcYEqc9\nHBqADaiig6IsxTYgSpGXzy/8v9md1bsp9R6byP0VcvR1x+bcbXZ2ODAFdr8g7bPF\nfddxe2efEuswR8nHh73BqXbetqq3QR9E7HWxGnnzIr3svzt2PhuHoYwtgh6wRX3M\nB+Pzj0t084596S8hGrm7/Og=\n-----END PRIVATE KEY-----\n",
  "client_email": "jrcrm-4f580@appspot.gserviceaccount.com",
  "client_id": "105488431180560619128",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/jrcrm-4f580%40appspot.gserviceaccount.com"
}
  
  ''';
  static final spreadSheetId = '1IAx3lOPkMiZqWT6AjyAmzYebE6WjcYZsS6Kfn8ffwG0';
  static final gsheets = GSheets(credentials);
  static Worksheet? worksheet;
  static Future init() async {
    try {
      final spreadSheet = await gsheets.spreadsheet(spreadSheetId);
      worksheet = await getWorkSheet(spreadSheet, title: 'Sheet1');
      final firstRow = DataFields.getfields();
      worksheet!.values.insertRow(1, firstRow);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  static Future<Worksheet> getWorkSheet(Spreadsheet spreadsheet,
      {required String title}) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return await spreadsheet.worksheetByTitle(title)!;
      print(e.toString());
    }
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (worksheet == null) return;
    worksheet!.values.map.appendRows(rowList);
  }
}
