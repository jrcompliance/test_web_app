import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:test_web_app/Constants/Calenders.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/Constants/shape.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Constants/Fileview.dart';
import 'package:http/http.dart' as http;

class AdvanceCustomAlert extends StatefulWidget {
  String invoiceid;
  String url;
  DateTime date;
  String email;
  String name;
  AdvanceCustomAlert(
      {required this.invoiceid,
      required this.url,
      required this.date,
      required this.email,
      required this.name});

  @override
  State<AdvanceCustomAlert> createState() => _AdvanceCustomAlertState();
}

class _AdvanceCustomAlertState extends State<AdvanceCustomAlert> {
  final List<String> paymentstatus = ["PAID", "PARTIALLY PAID", "CANCEL"];
  String selectedValue1 = "CANCEL";
  final TextEditingController _externalController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _internalController = TextEditingController();
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Invoice Generated On:\n${DateFormat("dd MMM,yyyy").format(widget.date)}",
              style: TxtStls.fieldtitlestyle,
            ),
            Text("Invoice Cancelled On:\n04 April,2022",
                style: TxtStls.fieldtitlestyle),
          ],
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        content: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: size.height * 0.7,
              width: size.width * 0.35,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Card(
                    elevation: 40,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Trade name",
                            style: TxtStls.fieldtitlestyle,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: btnColor.withOpacity(0.2),
                                    child: Icon(Icons.person, color: btnColor),
                                  ),
                                  title: Text(
                                    widget.name,
                                    style: TxtStls.fieldtitlestyle,
                                  ),
                                  subtitle: Text(
                                    widget.email,
                                    style: TxtStls.fieldtitlestyle,
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: FlatButton(
                                    color: btnColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Text("Preview",
                                        style: TxtStls.fieldstyle1),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      fileview1(context, widget.invoiceid,
                                          widget.url);
                                    },
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: IconButton(
                                      onPressed: () {
                                        downloadInvoice(widget.url);
                                      },
                                      icon: Icon(
                                        Icons.save_alt,
                                        color: btnColor,
                                      ))),
                              Expanded(
                                  flex: 1,
                                  child: IconButton(
                                      onPressed: () {
                                        _printPdf();
                                      },
                                      icon:
                                          Icon(Icons.print, color: btnColor))),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Invoice : JR" + widget.invoiceid,
                            style: TxtStls.fieldtitlestyle,
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Internal Notes",
                                    style: TxtStls.titlestyle14,
                                  )),
                              Expanded(
                                  flex: 6,
                                  child: SizedBox(
                                      height: size.height * 0.05,
                                      child: field(
                                          _internalController, "", 1, true))),
                              Expanded(flex: 2, child: popupMenu())
                            ],
                          ),
                          spacer(),
                          Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    "External Notes",
                                    style: TxtStls.titlestyle14,
                                  )),
                              Expanded(
                                  flex: 6,
                                  child: SizedBox(
                                      height: size.height * 0.05,
                                      child: field(
                                          _externalController, "", 1, true))),
                              Expanded(flex: 2, child: popupMenu())
                            ],
                          ),
                          spacer(),
                          Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Reference ID",
                                    style: TxtStls.titlestyle14,
                                  )),
                              Expanded(
                                  flex: 6,
                                  child: SizedBox(
                                      height: size.height * 0.05,
                                      child: field(
                                          _referenceController, "", 1, true))),
                              Expanded(flex: 2, child: popupMenu())
                            ],
                          ),
                          spacer(),
                          Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Email",
                                    style: TxtStls.titlestyle14,
                                  )),
                              Expanded(
                                  flex: 6,
                                  child: SizedBox(
                                      height: size.height * 0.05,
                                      child: field(
                                          _emailController, "", 1, true))),
                              Expanded(flex: 2, child: popupMenu())
                            ],
                          ),
                          spacer(),
                          Row(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Text(
                                    "Payment Status",
                                    style: TxtStls.titlestyle14,
                                  )),
                              Expanded(
                                flex: 4,
                                child: Card(
                                  elevation: 20,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: DropdownButtonFormField2(
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                    ),
                                    isExpanded: true,
                                    hint: Row(
                                      children: [
                                        Icon(
                                          Icons.wysiwyg_sharp,
                                          color: AbgColor,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Select",
                                          style: TextStyle(
                                              color: AbgColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: AbgColor,
                                    ),
                                    iconSize: 30,
                                    buttonHeight: 50,
                                    buttonPadding:
                                        EdgeInsets.only(left: 20, right: 10),
                                    dropdownDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    items: paymentstatus
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(item,
                                                  style:
                                                      TxtStls.fieldtitlestyle),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue1 = value.toString();
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Expanded(flex: 3, child: SizedBox())
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Text(
                                    "Cancelled On",
                                    style: TxtStls.titlestyle14,
                                  )),
                              Expanded(
                                flex: 4,
                                child: InkWell(
                                  child: Card(
                                    elevation: 20,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: SizedBox(
                                      height: size.height * 0.05,
                                      child: field(
                                          _dateController,
                                          "Calender",
                                          1,
                                          false,
                                          Icon(Icons.calendar_today_outlined)),
                                    ),
                                  ),
                                  onTap: () {
                                    MyCalenders.pickEndDate(
                                        context, _dateController);
                                  },
                                ),
                              ),
                              Expanded(flex: 3, child: SizedBox())
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: RaisedButton(
                              elevation: 40,
                              onPressed: () {},
                              child: Text("Save", style: TxtStls.fieldstyle1),
                              color: btnColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: size.height * -0.17,
                child: CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  radius: 60,
                  child: Icon(
                    Icons.assistant_photo,
                    color: Colors.white,
                    size: 50,
                  ),
                )),
          ],
        ));
  }

  Widget spacer() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Divider(
        height: 0.5,
        color: AbgColor,
      ),
    );
  }

  Widget field(_controller, hintText, maxlines, bool isenable, [icn, icn1]) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: deco,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.01,
        ),
        child: TextFormField(
          enabled: isenable,
          cursorColor: btnColor,
          controller: _controller,
          style: TxtStls.fieldstyle,
          decoration: InputDecoration(
            prefixIcon: icn1,
            errorStyle: ClrStls.errorstyle,
            suffixIcon: icn,
            hintText: hintText,
            hintStyle: TxtStls.fieldstyle,
            border: InputBorder.none,
          ),
          maxLines: maxlines,
        ),
      ),
    );
  }

  final List _clrslist = [btnColor, neClr, flwClr];
  var dropSelected;
  Widget dropdecor(IconData icon, String text, Color clr) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: clr.withOpacity(0.05),
      ),
      child: Row(
        children: [
          Container(
              child: Icon(
            icon,
            color: clr,
            size: 13,
          )),
          SizedBox(
            width: 10,
          ),
          Container(
            child: Text(
              text,
              style: TextStyle(
                  color: clr, fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget popupMenu() {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: PopupMenuButton(
        shape: TooltipShape(),
        offset: Offset(-40, 30),
        icon: Icon(
          Icons.more_horiz,
          color: btnColor,
        ),
        onSelected: (value) {
          setState(() {
            dropSelected = value;
          });
          print(value);
        },
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
                value: "EDIT",
                onTap: () {},
                child: dropdecor(Icons.edit, "EDIT", _clrslist[0])),
            PopupMenuItem(
              value: "DELETE",
              onTap: () {},
              child: dropdecor(Icons.delete, "DELETE", _clrslist[1]),
            ),
            PopupMenuItem(
                value: "ADD",
                onTap: () {},
                child: dropdecor(
                    Icons.add_circle_outline_outlined, "ADD", _clrslist[2])),
          ];
        },
      ),
    );
  }

  downloadInvoice(_url) async {
    if (!await launch(
      _url,
      forceWebView: true,
      forceSafariVC: true,
      enableJavaScript: true,
    )) throw 'Could not launch $_url';
  }

  Future<void> _printPdf() async {
    try {
      var data = await http.get(Uri.parse(widget.url));
      await Printing.layoutPdf(onLayout: (PdfPageFormat) => data.bodyBytes);
      print('Print ...');
      // final bool result = await Printing.layoutPdf(
      //     onLayout: (PdfPageFormat format) async =>
      //         (await generateDocument(format)).save());
    } catch (e) {
      print(e.toString());
    }
  }

  generateDocument(PdfPageFormat format) {}
}
