import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:test_web_app/Constants/Charts.dart';
import 'package:test_web_app/Constants/Fileview.dart';
import 'package:test_web_app/Constants/Services.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/Constants/shape.dart';
import 'package:test_web_app/Models/ActivityModels.dart';
import 'package:test_web_app/Models/UserModels.dart';
import 'package:test_web_app/Providers/ActivityProvider.dart';
import 'package:test_web_app/Providers/AddDocumentsProvider.dart';
import 'package:test_web_app/Providers/AddServicesProvider.dart';
import 'package:test_web_app/Providers/RemoveServiceProvider.dart';


class DeatailsPopBox extends StatefulWidget {
   String Idocid;
   int CxID;
   String taskname;
   Timestamp startDate;
   String endDate;
   String priority;
   Timestamp lastseen;
   String cat;
   String message;
   String status;
   int s;
   int f;
   List assigns;
   int leadID;
   List<ActivityModel> list;


  DeatailsPopBox(
      {
        required this.Idocid,
        required this.CxID,
        required this.taskname,
        required this.status,
        required this.cat,
        required this.endDate,
        required this.message,
        required this.startDate,
        required this.priority,
        required this.lastseen,
        required this.f,
        required this.s,
        required this.assigns,required this.leadID,required this.list});

  @override
  _DeatailsPopBoxState createState() => _DeatailsPopBoxState();
}

class _DeatailsPopBoxState extends State<DeatailsPopBox> {
  bool _isGraph = false;
  var date1;
  var date2;
  var _isadvance;
  var _istds;
  var _isgst;
  var _islocation;
  var _issample;
  var _govtfee;
  var _testfee;
  TabController? _controller;
  int _selectedIndex = 0;
  int? opts;
  final List<bool> _isHover = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _paymentController = TextEditingController();
  final TextEditingController _dealController = TextEditingController();
  final TextEditingController _paymentRecieveController = TextEditingController();
  final TextEditingController _sampleController = TextEditingController();
  final TextEditingController _advanceController = TextEditingController();
  final TextEditingController _taxController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();
  final TextEditingController _tdsController = TextEditingController();


  Widget mytitile = Text(
    "Search Example",
    style: TextStyle(color: Colors.white),
  );
  Icon myicon = Icon(
    Icons.search,
    color: Colors.white,
  );
  final myGlobalkey = GlobalKey<ScaffoldState>();
  final TextEditingController _mysearchController = TextEditingController();
  List _mysearchList = [];
  bool _mySearching = false;
  String _mysearchText = "";
  List mysearchresult = [];

  void myvalues() {
    _mysearchList = [];
    _mysearchList.add("ETA certification");
    _mysearchList.add("ETA approval");
    _mysearchList.add("Recycler");
    _mysearchList.add("scrapper");
    _mysearchList.add("dispose off");
    _mysearchList.add("waste management services");
    _mysearchList.add("LMPC certificate for import");
    _mysearchList.add("LMPC certificate online");
    _mysearchList.add("LMPC certification");
    _mysearchList.add("Bio-medical waste management");
    _mysearchList.add("STQC certification");
    _mysearchList.add("CPCB guidelines for poultry farms");
    _mysearchList.add("CPCB guidelines for environmental management of dairy farms and gaushalas");
    _mysearchList.add("Delhi Pollution Control Committee (DPCC) & Waste Management Authorization");
    _mysearchList.add("Haryana State Pollution Control Board, HPCB");
    _mysearchList.add("Uttar Pradesh Pollution Control Board, UPPCB");
    _mysearchList.add("Maharashtra State Pollution Control Board, MPCB");
    _mysearchList.add("Delhi Forest Department");
    _mysearchList.add("Bihar State Pollution Control Board, BPCB");
    _mysearchList.add("Gujarat State Pollution Control Board, GPCB");
    _mysearchList.add("Maharashtra State Pollution Control Board, MPCBM");
    _mysearchList.add("Public limited company");
    _mysearchList.add("public limited incorporation");
    _mysearchList.add("incorporation of public limited company");
    _mysearchList.add("formation of public limited company");
    _mysearchList.add("public limited company formation");
    _mysearchList.add("Delhi Pollution Control Committee, DPCC");
    _mysearchList.add("DPCC registration");
    _mysearchList.add("CPCB DPCC");
    _mysearchList.add("DPCC approval");
    _mysearchList.add("CRA type approval");
    _mysearchList.add("Qatar type approval");
    _mysearchList.add("CRA Qatar type approval");
    _mysearchList.add("communications regulatory authority");
    _mysearchList.add("cra qatar");
    _mysearchList.add("NTC type approval");
    _mysearchList.add("NTC philippines type approval");
    _mysearchList.add("Philippines type approval / NTC Thailand type approval");
    _mysearchList.add("Thailand type approval");
    _mysearchList.add("Philippines radio type approval");
    _mysearchList.add("NTC approval");
    _mysearchList.add("NTC Philippines");
    _mysearchList.add("NTC list");
    _mysearchList.add("MTC type approval");
    _mysearchList.add("MTC Peru type approval");
    _mysearchList.add("Peru type approval");
    _mysearchList.add("Peru MTC telecom approval");
    _mysearchList.add("MTC certification");
    _mysearchList.add("TRA type approval");
    _mysearchList.add("TRA Oman type approval");
    _mysearchList.add("Oman type approval / TRA type approval");
    _mysearchList.add("TRA UAE type approval");
    _mysearchList.add("UAE type approval");
    _mysearchList.add("oman radio type approval");
    _mysearchList.add("TRA certification");
    _mysearchList.add("TRa registration");
    _mysearchList.add("ANRT type approval");
    _mysearchList.add("ANRT Morocco type approval");
    _mysearchList.add("Morocco type approval");
    _mysearchList.add("ANRT certification");
    _mysearchList.add("morocco anrt type");
    _mysearchList.add("TRA type approval");
    _mysearchList.add("TRA Lebanon type approval");
    _mysearchList.add("type approval");
    _mysearchList.add("TRA certificate");
    _mysearchList.add("TRA regulations");
    _mysearchList.add("CITRA type approval");
    _mysearchList.add("CITRA Kuwait type approval");
    _mysearchList.add("Kuwait type approval");
    _mysearchList.add("Kuwait CITRA");
    _mysearchList.add("CITRA regulations");
    _mysearchList.add("TRC Cambodia type approval");
    _mysearchList.add("Cambodia type approval");
    _mysearchList.add("TRC certification");
    _mysearchList.add("DSRT type approval");
    _mysearchList.add("Macau type approval");
    _mysearchList.add("DSRT Macau type approval");
    _mysearchList.add("Sirim type approval");
    _mysearchList.add("Malaysia type approval");
    _mysearchList.add("Sirim Malaysia type approval");
    _mysearchList.add("SIRIM certification");
    _mysearchList.add("SIRIM malaysia");
    _mysearchList.add("SIRIM QAS");
    _mysearchList.add("NTA type approval");
    _mysearchList.add("Nepal NTA type approval");
    _mysearchList.add("NTA type approval");
    _mysearchList.add("NTA Nepal type approval");
    _mysearchList.add("NTA imei");
    _mysearchList.add("NTA registration");
    _mysearchList.add("PTA type approval");
    _mysearchList.add("Pakistan PTA type approval");
    _mysearchList.add("PTA Pakistan type approval");
    _mysearchList.add("PTA mobile registration");
    _mysearchList.add("IMDA equipment registration");
    _mysearchList.add("Singapore IMDA equipment registration");
    _mysearchList.add("IMDA singapore equipment registration");
    _mysearchList.add("IMDA Telecom Approval");
    _mysearchList.add("imda telecommunication equipment");
    _mysearchList.add("IMDA certification");
    _mysearchList.add("IMDA standards");
    _mysearchList.add("TCRA type approval");
    _mysearchList.add("Tanzania TCRA type approval");
    _mysearchList.add("Tanzania type approval");
    _mysearchList.add("TCRA Tanzania type approval");
    _mysearchList.add("TCRA Tanzania");
    _mysearchList.add("CONATEL type approval");
    _mysearchList.add("CONATEL approval");
    _mysearchList.add("CONATEL Venezuela type approval");
    _mysearchList.add("Venezuela CONATEL approval");
    _mysearchList.add("ICT type approval certificate (TAC)");
    _mysearchList.add("Declaration of Conformity (DoC)");
    _mysearchList.add("VNTA type approval");
    _mysearchList.add("Vietnam type approval");
    _mysearchList.add("ICT Vietnam type approval");
    _mysearchList.add("VNTA Vietnam type approval");
    _mysearchList.add("ICT approval");
    _mysearchList.add("ICT Qatar");
    _mysearchList.add("MITIT approval");
    _mysearchList.add("MITIT Yemen type approval");
    _mysearchList.add("MITIT approval");
    _mysearchList.add("Yemen MITIT type approval");
    _mysearchList.add("Barbados Type Approval For Telecom and Radio Equipment");
    _mysearchList.add("Barbados type approval");
    _mysearchList.add("Barbados global approvals");
    _mysearchList.add("Barbados certification");
    _mysearchList.add("NOC Bangladesh");
    _mysearchList.add("Bangladesh NOC");
    _mysearchList.add("Bangladesh certification");
    _mysearchList.add("Bangladesh global approval");
    _mysearchList.add("AITI type approval");
    _mysearchList.add("Brunei AITI approval");
    _mysearchList.add("Brunei approval");
    _mysearchList.add("Brunei global approval");
    _mysearchList.add("Brunei certification");
    _mysearchList.add("AITI approval");
    _mysearchList.add("CRS Homologation");
    _mysearchList.add("Colombia CRS homologation");
    _mysearchList.add("Colombia homologation");
    _mysearchList.add("Colombia global approval");
    _mysearchList.add("Colombia certification");
    _mysearchList.add("SUTEL Approval");
    _mysearchList.add("Costa Rica SUTEL Approval");
    _mysearchList.add("Costa Rica approval");
    _mysearchList.add("Costa Rica global approval");
    _mysearchList.add("Costa Rica certification");
    _mysearchList.add("SUTEL certification");
    _mysearchList.add("Costa Rica type approval");
    _mysearchList.add("INDOTEL Type Approval");
    _mysearchList.add("Dominican Republic INDOTEL Type Approval");
    _mysearchList.add("Dominican Republic approval");
    _mysearchList.add("Dominican Republic global approval");
    _mysearchList.add("Dominican Republic certification");
    _mysearchList.add("Dominican Republic Type Approval");
    _mysearchList.add("ARCOTEL Type Approval");
    _mysearchList.add("Ecuador ARCOTEL Type Approval");
    _mysearchList.add("Ecuador type approval");
    _mysearchList.add("Ecuador global approval");
    _mysearchList.add("Ecuador certification");
    _mysearchList.add("ARCOTEL approval");
    _mysearchList.add("HKCA Telecom Equipment Certification");
    _mysearchList.add("HKCA certification");
    _mysearchList.add("HKCA registration");
    _mysearchList.add("HKCA Hong Kong certification");
    _mysearchList.add("Hong Kong HKCA certification");
    _mysearchList.add("Hong Kong certification");
    _mysearchList.add("Hong Kong approval");
    _mysearchList.add("NTRA Type Approval");
    _mysearchList.add("Egypt NTRA  Type Approval");
    _mysearchList.add("Egypt NTRA Approval");
    _mysearchList.add("NTRA Egypt approval");
    _mysearchList.add("NTRA Approval");
    _mysearchList.add("Egypt global approval");
    _mysearchList.add("Egypt certification");
    _mysearchList.add("Egypt radio type approval");
    _mysearchList.add("NTRA egypt, NTRA certification");
    _mysearchList.add("SDPPI Type Approval");
    _mysearchList.add("Indonesia SDPPI Type Approval");
    _mysearchList.add("Indonesia SDPPI Approval");
    _mysearchList.add("SDPPI Indonesia approval");
    _mysearchList.add("SDPPI Approval");
    _mysearchList.add("Indonesia global approval");
    _mysearchList.add("Indonesia certification");
    _mysearchList.add("SDPPI certification");
    _mysearchList.add("Indonesian standards");
    _mysearchList.add("ISRAEL Global Certification");
    _mysearchList.add("MoC approval");
    _mysearchList.add("MoC type approval");
    _mysearchList.add("MoE approval");
    _mysearchList.add("MoE type  approval");
    _mysearchList.add("SII type approval");
    _mysearchList.add("SII  approval");
    _mysearchList.add("Israel global certification");
    _mysearchList.add("Israel certification");
    _mysearchList.add("MoC certification");
    _mysearchList.add( "Israel MoC");
    _mysearchList.add("TRC type approval");
    _mysearchList.add("TRC Jordan type approval");
    _mysearchList.add("Jordan type approval / TRC type approval");
    _mysearchList.add("TRC Sri Lanka type approval");
    _mysearchList.add("Sri Lanka type approval");
    _mysearchList.add("Jordan TRC type approval");
    _mysearchList.add("TRC approval");
    _mysearchList.add("Telepermit Certificate");
    _mysearchList.add("New Zealand telepermit certificate");
    _mysearchList.add("New Zealand certification");
    _mysearchList.add("New Zealand global approval");
    _mysearchList.add("TRA approval");
    _mysearchList.add("Bahrain TRA approval");
    _mysearchList.add("Bahrain approval");
    _mysearchList.add("Bahrain global approval");
    _mysearchList.add("Bahrain certification");
    _mysearchList.add("Oman radio type approval");
    _mysearchList.add("UAE TRA");
    _mysearchList.add("Bahrain radio type approval");
    _mysearchList.add("Ministere des Technologies de la Communication");
    _mysearchList.add("Tunisia Type Approval");
    _mysearchList.add("Tunisia global approval");
    _mysearchList.add("Tunisia certification");
    _mysearchList.add("CITC Type Approval");
    _mysearchList.add("Saudi Arabia CITC Type Approval");
    _mysearchList.add("Saudi Arabia CITC Approval");
    _mysearchList.add("CITC Saudi Arabia approval");
    _mysearchList.add("CITC Approval");
    _mysearchList.add("Saudi Arabia certification");
    _mysearchList.add("Saudi Arabia global approval");
    _mysearchList.add("Saudi Arabia Radio type Approval");
    _mysearchList.add("CITC Certification");
    _mysearchList.add("CITC Saudi");
    _mysearchList.add("SUBTEL approval");
    _mysearchList.add("Chile SUBTEL approval");
    _mysearchList.add("Chile approval");
    _mysearchList.add("Chile global approval");
    _mysearchList.add("Chile certification");
    _mysearchList.add("chile radio type approval");
    _mysearchList.add("SUBTEL approval chile");
    _mysearchList.add("SUBTEL certification");
    _mysearchList.add("Punjab Pollution Control Board NOC, PPCB");
    _mysearchList.add("Karnataka Pollution Control Board NOC, KSPCB");
    _mysearchList.add("Madhya Pradesh Pollution Board NOC, MPPCB");
    _mysearchList.add("Rajasthan Pollution Board NOC, RPCB");
    _mysearchList.add("Tamil Nadu Pollution Board NOC, TNPCB");
    _mysearchList.add("Telangana Pollution Board NOC, TSPCB");
    _mysearchList.add("Chhattisgarh Pollution Board NOC, CPCB");
    _mysearchList.add("Jharkhand Pollution Board NOC, JSPCB");
    _mysearchList.add("Uttarakhand Environment Protection and Pollution Board NOC, UEPPCB");
    _mysearchList.add("Himachal Pradesh Pollution Board NOC, HPPCB");
    _mysearchList.add("West Bengal Pollution Board NOC, WBPCB");
    _mysearchList.add("Kerala Pollution Board NOC, KPCB");
    _mysearchList.add("Odisha Pollution Board NOC, OSPCB");
    _mysearchList.add("Puducherry Pollution Control Committee NOC, PPCC");
    _mysearchList.add("Sikkim Pollution Control Board NOC, SPCB-Sikkim");
    _mysearchList.add("Tripura State Pollution Control Committee NOC, TSPCB");
    _mysearchList.add("Goa State Pollution Control Board NOC, GSPCB");
    _mysearchList.add("Jammu & Kashmir Pollution Control Committee, JKPCB");
    _mysearchList.add("Meghalaya State Pollution Control Committee, MSPCB");
    _mysearchList.add("Andhra Pradesh Pollution Board NOC, APPCB");
    _mysearchList.add("One Person Company");
    _mysearchList.add("Limited Liability Partnership Registration");
    _mysearchList.add("Private Limited Company");
    _mysearchList.add("FSSAI");
    _mysearchList.add("DSC or Digital Signature Certificate");
    _mysearchList.add("IEC code");
    _mysearchList.add("Microfinance company registration");
    _mysearchList.add("NBFC registration");
    _mysearchList.add("Asset reconstruction company registration");
    _mysearchList.add("Mutual fund company registration");
    _mysearchList.add("BIS Certification");
    _mysearchList.add("Foreign Manufacturer Certification Scheme");
    _mysearchList.add("Indian Standards Institute Certification");
    _mysearchList.add("Compulsory Registration Scheme");
    _mysearchList.add("AYUSH Manufacturing License or AYUSH License");
    _mysearchList.add("TEC certificate");
    _mysearchList.add("WPC certification");
    _mysearchList.add("BEE certification");
    _mysearchList.add("AERB approval or AERB license");
    _mysearchList.add("EPR certificate");
    _mysearchList.add("Automotive Research Association of India certification");
    _mysearchList.add("ISO Certification");
    _mysearchList.add("FCC Certificate");
    _mysearchList.add("Federal Communications Commission");
    _mysearchList.add("NRTL Approval");
    _mysearchList.add("Nationally Recognized Testing Laboratory");
    _mysearchList.add("China CCC certification service");
    _mysearchList.add("CCC certificate");
    _mysearchList.add("CCC automotive certification");
    _mysearchList.add( "china CCC automotive certification");
    _mysearchList.add("China SRRC Certification");
    _mysearchList.add("SRRC certificate");
    _mysearchList.add("China NAL Certification");
    _mysearchList.add("NAL certificate");
    _mysearchList.add("China CCIS Certification");
    _mysearchList.add("CCIS certificate");
    _mysearchList.add("China MIIT Network approval license");
    _mysearchList.add("MIIT approval");
    _mysearchList.add("Ministry of Information and Information Technology Approval");
    _mysearchList.add("China CMIIT Radio Type Approval");
    _mysearchList.add("China Ministry of Industry and Information Technology approval");
    _mysearchList.add("China CEL Certification");
    _mysearchList.add("CEL Certificate");
    _mysearchList.add("NOM Certification");
    _mysearchList.add("NOM certificate");
    _mysearchList.add("IFETEL Certification");
    _mysearchList.add("IFETEL Certificate");
    _mysearchList.add("Japan PSE Mark Certification");
    _mysearchList.add("PSE Certificate");
    _mysearchList.add("Japan TELEC Certification service");
    _mysearchList.add("TELEC Certificate");
    _mysearchList.add("Japan VCCI Certification Service");
    _mysearchList.add("VCCI Certificate");
    _mysearchList.add("Japan Telecom Certification");
    _mysearchList.add("South Korean KC Certification");
    _mysearchList.add("KC certificate");
    _mysearchList.add("Taiwan BSMI Certification");
    _mysearchList.add("BSMI certificate");
    _mysearchList.add("NCC Type Approval");
    _mysearchList.add("National Communications Commission approval");
    _mysearchList.add("Regulatory Compliance Mark");
    _mysearchList.add("RCM Approval");
    _mysearchList.add("Minimum Energy Performance Standards");
    _mysearchList.add("MEPS Approval");
    _mysearchList.add("Hygienic certification");
    _mysearchList.add("Telecommunications Approval");
    _mysearchList.add("EAC approval");
    _mysearchList.add("FSB notifications");
    _mysearchList.add("GOST-R certification");
    _mysearchList.add("Radio import");
    _mysearchList.add("ICASA Telecom Equipment Type Approval");
    _mysearchList.add("Independent Communication Authority of South Africa approval");
    _mysearchList.add("NRCS certification");
    _mysearchList.add("National Regulator for Compulsory Specifications certification");
    _mysearchList.add("SABS certification");
    _mysearchList.add("South African Bureau of Standards certification");
    _mysearchList.add("KEBS certification");
    _mysearchList.add("NRTA certification");
    _mysearchList.add("National Telecommunication Regulatory Authority certification");
    _mysearchList.add("CoC certificate, Certificat de controle de qualite certification");
    _mysearchList.add("Korea Conformity Assessment System for Broadcasting and Communications Equipment certification");
    _mysearchList.add("CE certification, Conformite Europeenne certification");
    _mysearchList.add("UKCA mark");
    _mysearchList.add("UK Conformity Assessed mark");
    _mysearchList.add("IEC/EN 62368-1 implementation");
    _mysearchList.add("ANATEL Type Approval");
    _mysearchList.add("Agencia Nacional de Telecomunicaciones type approval");
    _mysearchList.add("INMETRO certification");
    _mysearchList.add("Institute of Metrology");
    _mysearchList.add("Standardisation and Industrial Quality certification");
    _mysearchList.add("ENACOM approval, Ente Nacional de Comunicaciones approval");
    _mysearchList.add("IRAM certification");
    _mysearchList.add("Instituto Argentino de Normalizacion y Certificacion");
    _mysearchList.add("Industry Canada (IC) Certification");
  }


  void _myhandleSearchEnd() {
    setState(() {
      this.myicon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      _mySearching = false;
      _mysearchController.clear();
    });
  }

  void mysearchOperation(String searchText) {
    mysearchresult.clear();
    if (_mySearching != null) {
      for (int i = 0; i < _mysearchList.length; i++) {
        String data = _mysearchList[i];
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          setState((){});
          mysearchresult.add(data);
        }
      }
    }
  }
  @override
  void initState() {
    super.initState();
    myvalues();
    setState(() {
      print(widget.Idocid);
      Provider.of<ActivityProvider>(context,listen: false).getAllActivitys(widget.Idocid);
    });
  }
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    String createDate = DateFormat('EEE | MMM dd, yy').format(widget.startDate.toDate());
    DateTime dt = DateTime.parse(widget.endDate);
    String deadline = DateFormat('EEE | MMM dd, yy').format(dt);
    String lastview = DateFormat('EEE | MMM dd, yy').format(widget.lastseen.toDate());
    String lastviewTime = DateFormat('hh:mm a').format(widget.lastseen.toDate());
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      actionsPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.all(0),
      buttonPadding: EdgeInsets.all(0),
      backgroundColor: Colors.white.withOpacity(0.9),
      title: Container(
        width: size.width * 0.85,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset("assets/Logos/Controlifylogo.png",
                height: 50,
                width: 500,
                filterQuality: FilterQuality.high,fit: BoxFit.cover,),
            Column(
              children: [
                Text(
                  "CxID: "+widget.CxID.toString(),
                  style: TxtStls.fieldtitlestyle,
                ),
                Text(
                  "LeadID: JRL-${widget.leadID<10?"0${widget.leadID}":widget.leadID}",
                  style: TxtStls.fieldtitlestyle,
                ),
              ],
            ),
            CircleAvatar(
              backgroundColor: neClr.withOpacity(0.1),
              child: IconButton(
                hoverColor: Colors.transparent,
                tooltip: "Close Window",
                icon: Icon(Icons.close),
                color: neClr,
                onPressed: () {
                  UpdateServices.lastseenUpdate(widget.Idocid);
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {

          _mysearchController.addListener(() {
            if (_mysearchController.text.isEmpty) {
              setState(() {
                _mySearching = false;
                _mysearchText = "";
              });
            } else {
              setState(() {
                _mySearching = true;
                _mysearchText = _searchController.text;
              });
            }
          });
          return Container(
            width: size.width * 0.85,
            height: size.height * 0.85,
            decoration: BoxDecoration(
              color: AbgColor.withOpacity(0.0001),
            ),
            child: Row(
              children: [
                Container(
                  width: size.width * 0.85 / 2,
                  height: size.height * 0.85,
                  color: AbgColor.withOpacity(0.0001),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: size.width * 0.85 / 2,
                            decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                    child: Tooltip(
                                      message: "Create Date",
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            CircleAvatar(
                                                backgroundColor:
                                                btnColor.withOpacity(0.1),
                                                child: _isHover[0]
                                                    ? Lottie.asset(
                                                  "assets/Lotties/createdate.json",
                                                )
                                                    : Icon(
                                                  Icons
                                                      .calendar_today_outlined,
                                                  color: btnColor,
                                                  size: 20,
                                                )),
                                            Text(createDate,
                                                style: TxtStls.fieldstyle),
                                          ],
                                        ),
                                      ),
                                    ),
                                    onHover: (value) {
                                      _isHover[0] = value;
                                      setState(() {});
                                    },
                                    onTap: () {}),
                                Container(
                                  color: Color(0xFFE0E0E0),
                                  height: 40,
                                  width: 1,
                                ),
                                InkWell(
                                    onTap: () {},
                                    child: Tooltip(
                                      message: "End Date",
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            CircleAvatar(
                                                backgroundColor:
                                                btnColor.withOpacity(0.1),
                                                child: Lottie.asset(
                                                    "assets/Lotties/lastdate.json",
                                                    animate: _isHover[1])),
                                            Text(deadline,
                                                style: TxtStls.fieldstyle)
                                          ],
                                        ),
                                      ),
                                    ),
                                    onHover: (value) {
                                      _isHover[1] = value;
                                      setState(() {});
                                    }),
                                Container(
                                  color: Color(0xFFE0E0E0),
                                  height: 40,
                                  width: 1,
                                ),
                                Tooltip(
                                  message: "Priority",
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: CircleAvatar(
                                        backgroundColor:
                                        FlagService.pricolorget(widget.priority)
                                            .withOpacity(0.1),
                                        child: Icon(
                                          Icons.flag,
                                          color:
                                          FlagService.pricolorget(widget.priority),
                                        ),
                                      )),
                                ),
                                Container(
                                  color: Color(0xFFE0E0E0),
                                  height: 40,
                                  width: 1,
                                ),
                                InkWell(
                                  child: Tooltip(
                                    message: "Last Seen",
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          CircleAvatar(
                                              backgroundColor:
                                              btnColor.withOpacity(0.1),
                                              child: SizedBox(
                                                width: 50,
                                                height: 50,
                                                child: _isHover[2]
                                                    ? Lottie.asset(
                                                  "assets/Lotties/lastseen.json",
                                                  fit: BoxFit.fill,
                                                )
                                                    : Icon(
                                                  Icons.remove_red_eye,
                                                  color: btnColor,
                                                  size: 32,
                                                ),
                                              )),
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(lastview,
                                                  style: TxtStls.fieldstyle),
                                              Text(
                                                lastviewTime,
                                                style: TxtStls.fieldstyle,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  onHover: (value) {
                                    _isHover[2] = value;
                                    setState(() {});
                                  },
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: size.width * 0.85 / 2,
                            decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    CircleAvatar(
                                        backgroundColor:
                                        btnColor.withOpacity(0.1),
                                        child:
                                        Icon(Icons.work, color: btnColor)),
                                    Text("Organisation",
                                        style: TxtStls.fieldstyle)
                                  ],
                                ),
                                Container(
                                  color: Color(0xFFE0E0E0),
                                  height: 40,
                                  width: 1,
                                ),
                                Container(
                                    width: size.width * 0.85 / 3.3,
                                    child: StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection("Tasks")
                                          .where("id", isEqualTo: widget.Idocid)
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                          snapshot) {
                                        if (!snapshot.hasData) {
                                          return Container();
                                        }
                                        return ListView.builder(
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (_, index) {
                                            return ListTile(
                                              leading: CircleAvatar(
                                                backgroundColor:
                                                btnColor.withOpacity(0.2),
                                                child: SizedBox(
                                                  width: 30,
                                                  height: 30,
                                                  child: HtmlElementView(
                                                      viewType: snapshot.data!
                                                          .docs[index]["logo"]),
                                                ),
                                              ),
                                              title: Text(
                                                  snapshot.data!.docs[index]
                                                  ["companyname"],
                                                  style: TxtStls.fieldstyle),
                                              trailing: CircleAvatar(
                                                maxRadius: 15,
                                                child: IconButton(
                                                  hoverColor:
                                                  Colors.transparent,
                                                  icon: Icon(
                                                    Icons.edit,
                                                    size: 12.5,
                                                    color: btnColor,
                                                  ),
                                                  onPressed: () {},
                                                ),
                                                backgroundColor:
                                                btnColor.withOpacity(0.075),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                            width: size.width * 0.85 / 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor:
                                      btnColor.withOpacity(0.1),
                                      child: Lottie.asset(
                                          "assets/Lotties/check.json",
                                          fit: BoxFit.fitHeight),
                                    ),
                                    Text("Manage Contacts",
                                        style: TxtStls.fieldstyle),
                                  ],
                                ),
                                Container(
                                  width: size.width * 0.85 / 3.1,
                                  alignment: Alignment.centerRight,
                                  child: PopupMenuButton(
                                    offset: Offset(size.width * 0.4, 32),
                                    elevation: 10.0,
                                    icon: Icon(
                                      Icons.add_box_rounded,
                                      color: btnColor,
                                    ),
                                    onSelected: (int value) {
                                      opts = value;
                                      setState(() {});
                                    },
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                            value: 2,
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                                color: neClr.withOpacity(0.1),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceEvenly,
                                                children: [
                                                  Icon(
                                                    Icons.delete,
                                                    size: 15,
                                                    color: neClr,
                                                  ),
                                                  Text(
                                                    "Delete",
                                                    style: ClrStls.endClr,
                                                  )
                                                ],
                                              ),
                                            )),
                                      ];
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                            width: size.width * 0.85 / 2,
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("Tasks")
                                  .where("id", isEqualTo: widget.Idocid)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return Container();
                                }
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (_, index) {
                                    List<dynamic> contactlist = snapshot
                                        .data!.docs[index]["CompanyDetails"];
                                    return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                        AlwaysScrollableScrollPhysics(),
                                        itemCount: contactlist.length,
                                        itemBuilder: (_, i) {
                                          return Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: Card(
                                              elevation: 10,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.0),
                                                height: 50,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceAround,
                                                  children: [
                                                    Expanded(
                                                      flex: 3,
                                                      child: Text(
                                                          contactlist[i]
                                                          ["contactperson"],
                                                          style: TxtStls
                                                              .fieldstyle),
                                                    ),
                                                    Expanded(
                                                        flex: 3,
                                                        child: RichText(
                                                          text: TextSpan(
                                                            children: [
                                                              WidgetSpan(
                                                                child: Icon(
                                                                  Icons.mail,
                                                                  color: Colors
                                                                      .green,
                                                                  size: 15,
                                                                ),
                                                              ),
                                                              WidgetSpan(
                                                                child: SizedBox(
                                                                  width: 5,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                  text: contactlist[
                                                                  i]
                                                                  ["email"],
                                                                  style: TxtStls
                                                                      .fieldstyle),
                                                            ],
                                                          ),
                                                        )),
                                                    Expanded(
                                                      flex: 3,
                                                      child: RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            WidgetSpan(
                                                              child: Icon(
                                                                Icons.call,
                                                                color: AbgColor,
                                                                size: 15,
                                                              ),
                                                            ),
                                                            WidgetSpan(
                                                              child: SizedBox(
                                                                width: 5,
                                                              ),
                                                            ),
                                                            TextSpan(
                                                                text:
                                                                contactlist[
                                                                i][
                                                                "phone"],
                                                                style: TxtStls
                                                                    .fieldstyle),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                        flex: 1,
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                          btnColor
                                                              .withOpacity(
                                                              0.1),
                                                          child:
                                                          PopupMenuButton(
                                                            offset:
                                                            Offset(-50, 32),
                                                            elevation: 10.0,
                                                            shape:
                                                            TooltipShape(),
                                                            icon: Icon(
                                                              Icons.more_horiz,
                                                              color: btnColor,
                                                            ),
                                                            onSelected:
                                                                (int value) {
                                                              opts = value;
                                                              setState(() {});
                                                            },
                                                            itemBuilder:
                                                                (context) {
                                                              return [
                                                                PopupMenuItem(
                                                                    value: 1,
                                                                    child:
                                                                    Container(
                                                                      padding:
                                                                      EdgeInsets.all(
                                                                          5),
                                                                      decoration:
                                                                      BoxDecoration(
                                                                        borderRadius:
                                                                        BorderRadius.all(Radius.circular(5)),
                                                                        color: btnColor
                                                                            .withOpacity(0.1),
                                                                      ),
                                                                      child:
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.edit,
                                                                            size:
                                                                            15,
                                                                            color:
                                                                            btnColor,
                                                                          ),
                                                                          Text(
                                                                            "Edit",
                                                                            style:
                                                                            ClrStls.tnClr,
                                                                          )
                                                                        ],
                                                                      ),
                                                                    )),
                                                                PopupMenuItem(
                                                                    value: 2,
                                                                    child:
                                                                    Container(
                                                                      padding:
                                                                      EdgeInsets.all(
                                                                          5),
                                                                      decoration:
                                                                      BoxDecoration(
                                                                        borderRadius:
                                                                        BorderRadius.all(Radius.circular(5)),
                                                                        color: neClr
                                                                            .withOpacity(0.1),
                                                                      ),
                                                                      child:
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.delete,
                                                                            size:
                                                                            15,
                                                                            color:
                                                                            neClr,
                                                                          ),
                                                                          Text(
                                                                            "Delete",
                                                                            style:
                                                                            ClrStls.endClr,
                                                                          )
                                                                        ],
                                                                      ),
                                                                    )),
                                                              ];
                                                            },
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: bgColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text("Attachments :",
                                          style: TxtStls.fieldtitlestyle),
                                      Expanded(
                                        child: Container(
                                          width: size.width * 0.20,
                                          child: StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection("Tasks")
                                                  .where("id", isEqualTo: widget.Idocid)
                                                  .snapshots(),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<QuerySnapshot>
                                                  snapshot) {
                                                if (!snapshot.hasData) {
                                                  return Container(
                                                      width: 100,
                                                      height: 100,
                                                      child: Image.asset(
                                                          "assets/Images/pdf.png"));
                                                }
                                                return ListView.separated(
                                                  separatorBuilder:
                                                      (_, index) =>
                                                      SizedBox(height: 1),
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                  Axis.vertical,
                                                  physics:
                                                  AlwaysScrollableScrollPhysics(),
                                                  itemCount: snapshot
                                                      .data!.docs.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                      int index) {
                                                    List attachments1 = snapshot
                                                        .data!.docs[index]
                                                    ["Attachments1"];
                                                    return ListView.separated(
                                                      shrinkWrap: true,
                                                      itemCount:
                                                      attachments1.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                          i) {
                                                        return ListTile(
                                                          leading: SizedBox(
                                                            height:
                                                            size.height *
                                                                0.025,
                                                            child: Image.asset(
                                                                "assets/Images/pdf.png",
                                                                filterQuality:
                                                                FilterQuality
                                                                    .high,
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                          title: Text(
                                                            attachments1[i]
                                                            ['name'],
                                                            style: TxtStls
                                                                .fieldstyle,
                                                          ),
                                                          onTap: () {
                                                            fileview1(
                                                                context,
                                                                attachments1[i]
                                                                ["name"],
                                                                attachments1[i]
                                                                ["url"]);
                                                          },
                                                        );
                                                      },
                                                      separatorBuilder:
                                                          (BuildContext context,
                                                          int index) =>
                                                          Divider(
                                                              color: grClr),
                                                    );
                                                  },
                                                );
                                              }),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        alignment: Alignment.center,
                                        height: size.height * 0.05,
                                        width: size.width * 0.20,
                                        decoration: BoxDecoration(
                                            border: Border(
                                                top: BorderSide(
                                                    color: txtColor
                                                        .withOpacity(0.5)))),
                                        child: MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15))),
                                          color: btnColor,
                                          child: Text("Upload",
                                              style: TxtStls.fieldstyle1),
                                          onPressed: () {
                                            Provider.of<AddDocumentsProvider>(
                                                context,
                                                listen: false)
                                                .addDocument(widget.Idocid);
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  decoration: BoxDecoration(
                                      color: bgColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text("Services Obtained :",
                                          style: TxtStls.fieldtitlestyle),
                                      Card(
                                        elevation: 10,
                                        child: Container(
                                          width: size.width * 0.2,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0))),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, right: 15, top: 2),
                                            child: TextFormField(
                                              controller: _mysearchController,
                                              style: TxtStls.fieldstyle,
                                              decoration: new InputDecoration(
                                                  suffixIcon: _mySearching
                                                      ? IconButton(
                                                    icon: Icon(
                                                      Icons.cancel,
                                                      color: btnColor,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {});
                                                      _mySearching !=
                                                          _mySearching;
                                                      _myhandleSearchEnd();
                                                    },
                                                  )
                                                      : Icon(Icons.search,
                                                      color: btnColor),
                                                  border: InputBorder.none,
                                                  hintText: "Search...",
                                                  hintStyle:
                                                  TxtStls.fieldstyle),
                                              onChanged: mysearchOperation,
                                            ),
                                          ),
                                        ),
                                      ),
                                      StatefulBuilder(builder:
                                          (BuildContext context,
                                          StateSetter setState) {
                                        return _mysearchController
                                            .text.isNotEmpty
                                            ? Flexible(
                                          flex: 1,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                            mysearchresult.length,
                                            itemBuilder:
                                                (BuildContext context,
                                                int index) {
                                              String listData =
                                              mysearchresult[index];
                                              return ListTile(
                                                title: Text(
                                                    listData.toString(),
                                                    style: TxtStls
                                                        .fieldstyle),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            10.0))),
                                                onTap: () {
                                                  Provider.of<AddServiceProvider>(
                                                      context,
                                                      listen: false)
                                                      .addService(
                                                      widget.Idocid,
                                                      mysearchresult[
                                                      index])
                                                      .then((value) =>
                                                      _mysearchController
                                                          .clear());
                                                },
                                              );
                                            },
                                          ),
                                        )
                                            : Flexible(
                                          child: StreamBuilder(
                                              stream: FirebaseFirestore
                                                  .instance
                                                  .collection("Tasks")
                                                  .where("id",
                                                  isEqualTo: widget.Idocid)
                                                  .snapshots(),
                                              builder: (BuildContext
                                              context,
                                                  AsyncSnapshot<
                                                      QuerySnapshot>
                                                  snapshot) {
                                                if (!snapshot.hasData) {
                                                  return Container();
                                                }
                                                return ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                  AlwaysScrollableScrollPhysics(),
                                                  itemCount: snapshot
                                                      .data!.docs.length,
                                                  itemBuilder:
                                                      (BuildContext
                                                  context,
                                                      int index) {
                                                    List certificates =
                                                    snapshot.data!
                                                        .docs[
                                                    index][
                                                    "Certificates"];
                                                    String id = snapshot
                                                        .data!
                                                        .docs[index]
                                                    ["id"];
                                                    return Wrap(
                                                      children:
                                                      certificates
                                                          .map((e) =>
                                                          service(
                                                              e,
                                                              id))
                                                          .toList(),
                                                    );
                                                  },
                                                );
                                              }),
                                        );
                                      })
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: cat == "WON"
                            ? Padding(
                          padding:
                          const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              color: bgColor,
                            ),
                            child: DefaultTabController(
                              initialIndex: _selectedIndex,
                              length: 3,
                              child: Scaffold(
                                backgroundColor: bgColor,
                                appBar: AppBar(
                                  toolbarHeight: 30,
                                  backgroundColor: bgColor,
                                  elevation: 0.0,
                                  automaticallyImplyLeading: false,
                                  centerTitle: true,
                                  title: TabBar(
                                    controller: _controller,
                                    indicator: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(30),
                                      color: neClr,
                                    ),
                                    tabs: [
                                      Tab(child: Text("Payment Terms 1")),
                                      Tab(child: Text("Payment Terms 2")),
                                      Tab(child: Text("Comments")),
                                    ],
                                  ),
                                ),
                                body: TabBarView(
                                  controller: _controller,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceAround,
                                            children: [
                                              Container(
                                                color: Color(0xFFE0E0E0),
                                                height: 80,
                                                width: 1,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text("Advance required",
                                                      style: TxtStls
                                                          .fieldtitlestyle),
                                                  Row(
                                                    children: [
                                                      Radio(
                                                          value: "YES",
                                                          groupValue:
                                                          _isadvance,
                                                          onChanged:
                                                              (value) {
                                                            _isadvance =
                                                                value;
                                                            setState(
                                                                    () {});
                                                          }),
                                                      Text("YES",
                                                          style: TxtStls
                                                              .fieldstyle)
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Radio(
                                                          value: "NO",
                                                          groupValue:
                                                          _isadvance,
                                                          onChanged:
                                                              (value) {
                                                            _isadvance =
                                                                value;
                                                            setState(
                                                                    () {});
                                                          }),
                                                      Text("NO",
                                                          style: TxtStls
                                                              .fieldstyle)
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                color: Color(0xFFE0E0E0),
                                                height: 80,
                                                width: 1,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text("TDS Applicable",
                                                      style: TxtStls
                                                          .fieldtitlestyle),
                                                  Row(
                                                    children: [
                                                      Radio(
                                                          value: "YES",
                                                          groupValue:
                                                          _istds,
                                                          onChanged:
                                                              (value) {
                                                            _istds =
                                                                value;
                                                            setState(
                                                                    () {});
                                                          }),
                                                      Text("YES",
                                                          style: TxtStls
                                                              .fieldstyle)
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Radio(
                                                          value: "NO",
                                                          groupValue:
                                                          _istds,
                                                          onChanged:
                                                              (value) {
                                                            _istds =
                                                                value;
                                                            setState(
                                                                    () {});
                                                          }),
                                                      Text("NO",
                                                          style: TxtStls
                                                              .fieldstyle)
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                color: Color(0xFFE0E0E0),
                                                height: 80,
                                                width: 1,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text("GST Applicable",
                                                      style: TxtStls
                                                          .fieldtitlestyle),
                                                  Row(
                                                    children: [
                                                      Radio(
                                                          value: "YES",
                                                          groupValue:
                                                          _isgst,
                                                          onChanged:
                                                              (value) {
                                                            _isgst =
                                                                value;
                                                            setState(
                                                                    () {});
                                                          }),
                                                      Text("YES",
                                                          style: TxtStls
                                                              .fieldstyle)
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Radio(
                                                          value: "NO",
                                                          groupValue:
                                                          _isgst,
                                                          onChanged:
                                                              (value) {
                                                            _isgst =
                                                                value;
                                                            setState(
                                                                    () {});
                                                          }),
                                                      Text("NO",
                                                          style: TxtStls
                                                              .fieldstyle)
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                color: Color(0xFFE0E0E0),
                                                height: 80,
                                                width: 1,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text("Clients Location",
                                                      style: TxtStls
                                                          .fieldtitlestyle),
                                                  Row(
                                                    children: [
                                                      Radio(
                                                          value:
                                                          "Domestic",
                                                          groupValue:
                                                          _islocation,
                                                          onChanged:
                                                              (value) {
                                                            _islocation =
                                                                value;
                                                            setState(
                                                                    () {});
                                                          }),
                                                      Text("Domestic",
                                                          style: TxtStls
                                                              .fieldstyle)
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Radio(
                                                          value:
                                                          "International",
                                                          groupValue:
                                                          _islocation,
                                                          onChanged:
                                                              (value) {
                                                            _islocation =
                                                                value;
                                                            setState(
                                                                    () {});
                                                          }),
                                                      Text(
                                                          "International",
                                                          style: TxtStls
                                                              .fieldstyle)
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                color: Color(0xFFE0E0E0),
                                                height: 80,
                                                width: 1,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text("Sample required",
                                                      style: TxtStls
                                                          .fieldtitlestyle),
                                                  Row(
                                                    children: [
                                                      Radio(
                                                          value: "YES",
                                                          groupValue:
                                                          _issample,
                                                          onChanged:
                                                              (value) {
                                                            _issample =
                                                                value;
                                                            setState(
                                                                    () {});
                                                          }),
                                                      Text("YES",
                                                          style: TxtStls
                                                              .fieldstyle)
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Radio(
                                                          value: "NO",
                                                          groupValue:
                                                          _issample,
                                                          onChanged:
                                                              (value) {
                                                            _issample =
                                                                value;
                                                            setState(
                                                                    () {});
                                                          }),
                                                      Text("NO",
                                                          style: TxtStls
                                                              .fieldstyle)
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                color: Color(0xFFE0E0E0),
                                                height: 80,
                                                width: 1,
                                              ),
                                            ],
                                          ),
                                          Align(
                                            alignment:
                                            Alignment.bottomRight,
                                            child: CircleAvatar(
                                              backgroundColor: btnColor
                                                  .withOpacity(0.1),
                                              child: IconButton(
                                                icon: Icon(
                                                    Icons
                                                        .arrow_forward_rounded,
                                                    color: btnColor),
                                                onPressed: () {
                                                  _controller!.animateTo(
                                                      _selectedIndex +=
                                                      1);
                                                },
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceAround,
                                            children: [
                                              Container(
                                                color: Color(0xFFE0E0E0),
                                                height: 100,
                                                width: 1,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceAround,
                                                children: [
                                                  Text("Slab Percentage",
                                                      style: TxtStls
                                                          .fieldtitlestyle),
                                                  Container(
                                                    width: 170,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text("Advance : ",
                                                            style: TxtStls
                                                                .fieldstyle),
                                                        Container(
                                                          alignment:
                                                          Alignment
                                                              .center,
                                                          width: 70,
                                                          height: 25,
                                                          decoration:
                                                          deco,
                                                          child: Row(
                                                            children: <
                                                                Widget>[
                                                              Expanded(
                                                                flex: 1,
                                                                child:
                                                                Padding(
                                                                  padding:
                                                                  const EdgeInsets.only(
                                                                    left:
                                                                    4,
                                                                    right:
                                                                    2,
                                                                    bottom:
                                                                    12,
                                                                  ),
                                                                  child:
                                                                  TextFormField(
                                                                    style:
                                                                    TxtStls.fieldstyle,
                                                                    decoration:
                                                                    InputDecoration(border: InputBorder.none),
                                                                    controller:
                                                                    _advanceController,
                                                                    keyboardType:
                                                                    TextInputType.numberWithOptions(
                                                                      decimal:
                                                                      false,
                                                                      signed:
                                                                      true,
                                                                    ),
                                                                    inputFormatters: <
                                                                        TextInputFormatter>[],
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                height:
                                                                30.0,
                                                                child:
                                                                Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment.center,
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment.center,
                                                                  children: <
                                                                      Widget>[
                                                                    InkWell(
                                                                      child:
                                                                      Icon(
                                                                        Icons.arrow_drop_up,
                                                                        size: 12.0,
                                                                      ),
                                                                      onTap:
                                                                          () {
                                                                        int currentValue = int.parse(_advanceController.text);
                                                                        setState(() {
                                                                          currentValue++;
                                                                          _advanceController.text = (currentValue).toString(); // incrementing value
                                                                        });
                                                                      },
                                                                    ),
                                                                    InkWell(
                                                                      child:
                                                                      Icon(
                                                                        Icons.arrow_drop_down,
                                                                        size: 12.0,
                                                                      ),
                                                                      onTap:
                                                                          () {
                                                                        int currentValue = int.parse(_advanceController.text);
                                                                        setState(() {
                                                                          currentValue--;
                                                                          _advanceController.text = (currentValue > 0 ? currentValue : 0).toString(); // decrementing value
                                                                        });
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Container(
                                                    width: 170,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text("Tax : ",
                                                            style: TxtStls
                                                                .fieldstyle),
                                                        Container(
                                                          alignment:
                                                          Alignment
                                                              .center,
                                                          width: 70,
                                                          height: 25,
                                                          decoration:
                                                          deco,
                                                          child: Row(
                                                            children: <
                                                                Widget>[
                                                              Expanded(
                                                                flex: 1,
                                                                child:
                                                                Padding(
                                                                  padding:
                                                                  const EdgeInsets.only(
                                                                    left:
                                                                    4,
                                                                    right:
                                                                    2,
                                                                    bottom:
                                                                    12,
                                                                  ),
                                                                  child:
                                                                  TextFormField(
                                                                    style:
                                                                    TxtStls.fieldstyle,
                                                                    decoration:
                                                                    InputDecoration(border: InputBorder.none),
                                                                    controller:
                                                                    _taxController,
                                                                    keyboardType:
                                                                    TextInputType.numberWithOptions(
                                                                      decimal:
                                                                      false,
                                                                      signed:
                                                                      true,
                                                                    ),
                                                                    inputFormatters: <
                                                                        TextInputFormatter>[],
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                height:
                                                                30.0,
                                                                child:
                                                                Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment.center,
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment.center,
                                                                  children: <
                                                                      Widget>[
                                                                    InkWell(
                                                                      child:
                                                                      Icon(
                                                                        Icons.arrow_drop_up,
                                                                        size: 12.0,
                                                                      ),
                                                                      onTap:
                                                                          () {
                                                                        int currentValue = int.parse(_taxController.text);
                                                                        setState(() {
                                                                          currentValue++;
                                                                          _taxController.text = (currentValue).toString(); // incrementing value
                                                                        });
                                                                      },
                                                                    ),
                                                                    InkWell(
                                                                      child:
                                                                      Icon(
                                                                        Icons.arrow_drop_down,
                                                                        size: 12.0,
                                                                      ),
                                                                      onTap:
                                                                          () {
                                                                        int currentValue = int.parse(_taxController.text);
                                                                        setState(() {
                                                                          currentValue--;
                                                                          _taxController.text = (currentValue > 0 ? currentValue : 0).toString(); // decrementing value
                                                                        });
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Container(
                                                    width: 170,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text("Balance : ",
                                                            style: TxtStls
                                                                .fieldstyle),
                                                        Container(
                                                          alignment:
                                                          Alignment
                                                              .center,
                                                          width: 70,
                                                          height: 25,
                                                          decoration:
                                                          deco,
                                                          child: Row(
                                                            children: <
                                                                Widget>[
                                                              Expanded(
                                                                flex: 1,
                                                                child:
                                                                Padding(
                                                                  padding:
                                                                  const EdgeInsets.only(
                                                                    left:
                                                                    4,
                                                                    right:
                                                                    2,
                                                                    bottom:
                                                                    12,
                                                                  ),
                                                                  child:
                                                                  TextFormField(
                                                                    style:
                                                                    TxtStls.fieldstyle,
                                                                    decoration:
                                                                    InputDecoration(border: InputBorder.none),
                                                                    controller:
                                                                    _balanceController,
                                                                    keyboardType:
                                                                    TextInputType.numberWithOptions(
                                                                      decimal:
                                                                      false,
                                                                      signed:
                                                                      true,
                                                                    ),
                                                                    inputFormatters: <
                                                                        TextInputFormatter>[],
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                height:
                                                                30.0,
                                                                child:
                                                                Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment.center,
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment.center,
                                                                  children: <
                                                                      Widget>[
                                                                    InkWell(
                                                                      child:
                                                                      Icon(
                                                                        Icons.arrow_drop_up,
                                                                        size: 12.0,
                                                                      ),
                                                                      onTap:
                                                                          () {
                                                                        int currentValue = int.parse(_balanceController.text);
                                                                        setState(() {
                                                                          currentValue++;
                                                                          _balanceController.text = (currentValue).toString(); // incrementing value
                                                                        });
                                                                      },
                                                                    ),
                                                                    InkWell(
                                                                      child:
                                                                      Icon(
                                                                        Icons.arrow_drop_down,
                                                                        size: 12.0,
                                                                      ),
                                                                      onTap:
                                                                          () {
                                                                        int currentValue = int.parse(_balanceController.text);
                                                                        setState(() {
                                                                          currentValue--;
                                                                          _balanceController.text = (currentValue > 0 ? currentValue : 0).toString(); // decrementing value
                                                                        });
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Container(
                                                    width: 170,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text("TDS : ",
                                                            style: TxtStls
                                                                .fieldstyle),
                                                        Container(
                                                          alignment:
                                                          Alignment
                                                              .center,
                                                          width: 70,
                                                          height: 25,
                                                          decoration:
                                                          deco,
                                                          child: Row(
                                                            children: <
                                                                Widget>[
                                                              Expanded(
                                                                flex: 1,
                                                                child:
                                                                Padding(
                                                                  padding:
                                                                  const EdgeInsets.only(
                                                                    left:
                                                                    4,
                                                                    right:
                                                                    2,
                                                                    bottom:
                                                                    12,
                                                                  ),
                                                                  child:
                                                                  TextFormField(
                                                                    style:
                                                                    TxtStls.fieldstyle,
                                                                    decoration:
                                                                    InputDecoration(border: InputBorder.none),
                                                                    controller:
                                                                    _tdsController,
                                                                    keyboardType:
                                                                    TextInputType.numberWithOptions(
                                                                      decimal:
                                                                      false,
                                                                      signed:
                                                                      true,
                                                                    ),
                                                                    inputFormatters: <
                                                                        TextInputFormatter>[],
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                height:
                                                                30.0,
                                                                child:
                                                                Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment.center,
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment.center,
                                                                  children: <
                                                                      Widget>[
                                                                    InkWell(
                                                                      child:
                                                                      Icon(
                                                                        Icons.arrow_drop_up,
                                                                        size: 12.0,
                                                                      ),
                                                                      onTap:
                                                                          () {
                                                                        int currentValue = int.parse(_tdsController.text);
                                                                        setState(() {
                                                                          currentValue++;
                                                                          _tdsController.text = (currentValue).toString(); // incrementing value
                                                                        });
                                                                      },
                                                                    ),
                                                                    InkWell(
                                                                      child:
                                                                      Icon(
                                                                        Icons.arrow_drop_down,
                                                                        size: 12.0,
                                                                      ),
                                                                      onTap:
                                                                          () {
                                                                        int currentValue = int.parse(_tdsController.text);
                                                                        setState(() {
                                                                          currentValue--;
                                                                          _tdsController.text = (currentValue > 0 ? currentValue : 0).toString(); // decrementing value
                                                                        });
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                color: Color(0xFFE0E0E0),
                                                height: 80,
                                                width: 1,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text("Fee Payment",
                                                      style: TxtStls
                                                          .fieldtitlestyle),
                                                  Row(
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                              "Government Fee",
                                                              style: TxtStls
                                                                  .fieldtitlestyle),
                                                          Row(
                                                            children: [
                                                              Radio(
                                                                  value:
                                                                  "Client",
                                                                  groupValue:
                                                                  _govtfee,
                                                                  onChanged:
                                                                      (value) {
                                                                    _govtfee =
                                                                        value;
                                                                    setState(
                                                                            () {});
                                                                  }),
                                                              Text(
                                                                  "By Client",
                                                                  style: TxtStls
                                                                      .fieldstyle)
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Radio(
                                                                  value:
                                                                  "jr",
                                                                  groupValue:
                                                                  _govtfee,
                                                                  onChanged:
                                                                      (value) {
                                                                    _govtfee =
                                                                        value;
                                                                    setState(
                                                                            () {});
                                                                  }),
                                                              Text(
                                                                  "By JrCompliance",
                                                                  style: TxtStls
                                                                      .fieldstyle)
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(width: 10),
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                              "Testing Fee",
                                                              style: TxtStls
                                                                  .fieldtitlestyle),
                                                          Row(
                                                            children: [
                                                              Radio(
                                                                  value:
                                                                  "Client",
                                                                  groupValue:
                                                                  _testfee,
                                                                  onChanged:
                                                                      (value) {
                                                                    _testfee =
                                                                        value;
                                                                    setState(
                                                                            () {});
                                                                  }),
                                                              Text(
                                                                  "By Client",
                                                                  style: TxtStls
                                                                      .fieldstyle)
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Radio(
                                                                  value:
                                                                  "jr",
                                                                  groupValue:
                                                                  _testfee,
                                                                  onChanged:
                                                                      (value) {
                                                                    _testfee =
                                                                        value;
                                                                    setState(
                                                                            () {});
                                                                  }),
                                                              Text(
                                                                  "By JrCompliance",
                                                                  style: TxtStls
                                                                      .fieldstyle)
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                color: Color(0xFFE0E0E0),
                                                height: 80,
                                                width: 1,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceAround,
                                                children: [
                                                  Container(
                                                    width: 270,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text(
                                                            "Deal Size : ",
                                                            style: TxtStls
                                                                .fieldstyle),
                                                        Container(
                                                          alignment:
                                                          Alignment
                                                              .center,
                                                          width: 120,
                                                          height: 30,
                                                          decoration:
                                                          deco,
                                                          child: Padding(
                                                            padding:
                                                            EdgeInsets
                                                                .only(
                                                              left: 2,
                                                              right: 2,
                                                              bottom:
                                                              12.5,
                                                            ),
                                                            child:
                                                            TextFormField(
                                                              controller:
                                                              _dealController,
                                                              style: TxtStls
                                                                  .fieldstyle,
                                                              decoration:
                                                              InputDecoration(
                                                                hintStyle:
                                                                TxtStls
                                                                    .fieldstyle,
                                                                border: InputBorder
                                                                    .none,
                                                              ),
                                                              validator:
                                                                  (fullname) {
                                                                if (fullname!
                                                                    .isEmpty) {
                                                                  return "Name can not be empty";
                                                                } else if (fullname
                                                                    .length <
                                                                    3) {
                                                                  return "Name should be atleast 3 letters";
                                                                } else {
                                                                  return null;
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Container(
                                                    width: 270,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text(
                                                            "Payment Recieved Date : ",
                                                            style: TxtStls
                                                                .fieldstyle),
                                                        Container(
                                                          alignment:
                                                          Alignment
                                                              .center,
                                                          width: 120,
                                                          height: 30,
                                                          decoration:
                                                          deco,
                                                          child: Padding(
                                                            padding:
                                                            EdgeInsets
                                                                .only(
                                                              left: 2,
                                                              right: 2,
                                                              bottom:
                                                              12.5,
                                                            ),
                                                            child:
                                                            TextFormField(
                                                              controller:
                                                              _paymentRecieveController,
                                                              style: TxtStls
                                                                  .fieldstyle,
                                                              decoration:
                                                              InputDecoration(
                                                                hintStyle:
                                                                TxtStls
                                                                    .fieldstyle,
                                                                border: InputBorder
                                                                    .none,
                                                              ),
                                                              validator:
                                                                  (fullname) {
                                                                if (fullname!
                                                                    .isEmpty) {
                                                                  return "Name can not be empty";
                                                                } else if (fullname
                                                                    .length <
                                                                    3) {
                                                                  return "Name should be atleast 3 letters";
                                                                } else {
                                                                  return null;
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Container(
                                                    width: 270,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text(
                                                            "Samples Recieved Date : ",
                                                            style: TxtStls
                                                                .fieldstyle),
                                                        Container(
                                                          alignment:
                                                          Alignment
                                                              .center,
                                                          width: 120,
                                                          height: 30,
                                                          decoration:
                                                          deco,
                                                          child: Padding(
                                                            padding:
                                                            EdgeInsets
                                                                .only(
                                                              left: 2,
                                                              right: 2,
                                                              bottom:
                                                              12.5,
                                                            ),
                                                            child:
                                                            TextFormField(
                                                              controller:
                                                              _sampleController,
                                                              style: TxtStls
                                                                  .fieldstyle,
                                                              decoration:
                                                              InputDecoration(
                                                                hintStyle:
                                                                TxtStls
                                                                    .fieldstyle,
                                                                border: InputBorder
                                                                    .none,
                                                              ),
                                                              validator:
                                                                  (fullname) {
                                                                if (fullname!
                                                                    .isEmpty) {
                                                                  return "Name can not be empty";
                                                                } else if (fullname
                                                                    .length <
                                                                    3) {
                                                                  return "Name should be atleast 3 letters";
                                                                } else {
                                                                  return null;
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                color: Color(0xFFE0E0E0),
                                                height: 80,
                                                width: 1,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: btnColor
                                                    .withOpacity(0.1),
                                                child: IconButton(
                                                  icon: Icon(
                                                      Icons
                                                          .arrow_back_rounded,
                                                      color: btnColor),
                                                  onPressed: () {
                                                    _controller!.animateTo(
                                                        _selectedIndex -=
                                                        1);
                                                  },
                                                ),
                                              ),
                                              CircleAvatar(
                                                backgroundColor: btnColor
                                                    .withOpacity(0.1),
                                                child: IconButton(
                                                  icon: Icon(
                                                      Icons
                                                          .arrow_forward_rounded,
                                                      color: btnColor),
                                                  onPressed: () {
                                                    _controller!.animateTo(
                                                        _selectedIndex +=
                                                        1);
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    tab3(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                            : Container(),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width * 0.85 / 2,
                  height: size.height * 0.85,
                  color: AbgColor.withOpacity(0.0001),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: size.width * 0.85 / 2,
                            decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                    child: Container(
                                      padding: EdgeInsets.all(9),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Tooltip(
                                              message: "Agents",
                                              child: widget.assigns.length == 0
                                                  ? CircleAvatar(
                                                  backgroundColor: btnColor
                                                      .withOpacity(0.1),
                                                  child: Lottie.asset(
                                                    "assets/Lotties/agent.json",
                                                    fit: BoxFit.fill,
                                                    animate: _isHover[3],
                                                  ))
                                                  : SizedBox()),
                                          ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              physics: ClampingScrollPhysics(),
                                              itemCount: widget.assigns.length,
                                              itemBuilder: (_, index) {
                                                return ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            30.0)),
                                                    child: SizedBox(
                                                        width: 35,
                                                        height: 30,
                                                        child: Image.network(
                                                            widget.assigns[index]
                                                            ["image"],
                                                            fit: BoxFit.cover,
                                                            filterQuality:
                                                            FilterQuality
                                                                .high)));
                                              })
                                        ],
                                      ),
                                    ),
                                    onHover: (value) {
                                      _isHover[3] = value;
                                      setState(() {});
                                    },
                                    onTap: () {}),
                                Container(
                                  color: Color(0xFFE0E0E0),
                                  height: 40,
                                  width: 1,
                                ),
                                date1 == null && date2 == null
                                    ? InkWell(
                                    onTap: () {
                                      dateTimeRangePicker();
                                      setState(() {});
                                    },
                                    child: Tooltip(
                                      message: "Filters",
                                      child: Container(
                                        padding: EdgeInsets.all(9),
                                        child: CircleAvatar(
                                            backgroundColor:
                                            btnColor.withOpacity(0.1),
                                            child: Lottie.asset(
                                                "assets/Lotties/filter.json",
                                                animate: _isHover[4])),
                                      ),
                                    ),
                                    onHover: (value) {
                                      _isHover[4] = value;
                                      setState(() {});
                                    })
                                    : InkWell(
                                  child: Tooltip(
                                    message: "Clear Filters",
                                    child: CircleAvatar(
                                        backgroundColor:
                                        btnColor.withOpacity(0.1),
                                        child: Icon(Icons.cancel,
                                            color: btnColor)),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      setState(() {
                                        date1 = date2 = null;
                                      });
                                    });
                                  },
                                ),
                                Container(
                                  color: Color(0xFFE0E0E0),
                                  height: 40,
                                  width: 1,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Tooltip(
                                    message: "Current Status",
                                    child: CircleAvatar(
                                      backgroundColor:
                                      btnColor.withOpacity(0.1),
                                      child: _isHover[5]
                                          ? Lottie.asset(
                                          "assets/Lotties/live.json",
                                          fit: BoxFit.fill,
                                          reverse: true,
                                          animate: _isHover[5])
                                          : SizedBox(
                                        width: 35,
                                        height: 20,
                                        child: Image.asset(
                                          "assets/Images/live.png",
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onHover: (value) {
                                    _isHover[5] = value;
                                    setState(() {});
                                  },
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 150,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 3),
                                      decoration: BoxDecoration(
                                          color: StatusUpdateServices.CatColor(
                                              widget.cat
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      alignment: Alignment.center,
                                      child: Text(
                                        widget.cat,
                                        style: TxtStls.fieldstyle1,
                                      ),
                                    ),
                                    Container(
                                      width: 150,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 3),
                                      decoration: BoxDecoration(
                                          color:
                                          StatusUpdateServices.subcatColor(
                                              widget.status),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      alignment: Alignment.center,
                                      child: Text(
                                        widget.status,
                                        style: TxtStls.fieldstyle1,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  color: Color(0xFFE0E0E0),
                                  height: 40,
                                  width: 1,
                                ),
                                InkWell(
                                  child: Tooltip(
                                    message: "Statistics",
                                    child: CircleAvatar(
                                      backgroundColor:
                                      btnColor.withOpacity(0.1),
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: Lottie.asset(
                                              "assets/Lotties/stats.json",
                                              height: 20,
                                              animate: _isHover[6])),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _isGraph = !_isGraph;
                                    });
                                  },
                                  onHover: (value) {
                                    _isHover[6] = value;
                                    setState(() {});
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.01),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.25),
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                            width: size.width * 0.85 / 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                    child: Text(widget.taskname,
                                        style: TxtStls.fieldstyle)),
                                Expanded(
                                  child: Text(
                                    "Intial Message : " + createDate,
                                    style: TxtStls.fieldstyle,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    widget.message,
                                    style: TxtStls.fieldtitlestyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 8,
                          child: _isGraph
                              ? Chart(context, s, f)
                              : widget.list.length<=0?Text("No activity Found"):ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (_, i) => Divider(
                              height: 10,
                              color: Color(0xFFE0E0E0),
                            ),
                            itemCount:  date1==null&&date2==null?widget.list.length:activitylist1.length,

                            itemBuilder:
                                (BuildContext context, int index) {
                              String statecolor =
                                  widget.list[index].from;
                              String statecolor1 = widget.list[index].to;
                              String date = DateFormat("EEE | MMM dd, yy")
                                  .format(
                                  widget.list[index].when.toDate());
                              String time = DateFormat('hh:mm a').format(
                                  widget.list[index].when.toDate());
                              DateTime dt1 = DateTime.parse(
                                  widget.list[index].lastdate);
                              String lastDate =
                              DateFormat("EEE | MMM dd, yy")
                                  .format(dt1);

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: bgColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceAround,
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: btnColor
                                                        .withOpacity(0.1),
                                                    child: Icon(
                                                        Icons.fast_forward,
                                                        color: btnColor),
                                                  ),
                                                  Text(
                                                    date,
                                                    style: TxtStls.fieldstyle,
                                                  ),
                                                ],
                                              )),
                                          Container(
                                            color: Color(0xFFE0E0E0),
                                            height: 40,
                                            width: 1,
                                          ),
                                          Container(
                                              alignment: Alignment.center,
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceAround,
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor:
                                                    btnColor
                                                        .withOpacity(
                                                        0.1),
                                                    child: Icon(
                                                        Icons.timer,
                                                        color: btnColor),
                                                  ),
                                                  Text(time,
                                                      style: TxtStls
                                                          .fieldstyle),
                                                ],
                                              )),
                                          Container(
                                            color: Color(0xFFE0E0E0),
                                            height: 40,
                                            width: 1,
                                          ),
                                          Container(
                                              alignment: Alignment.center,
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceAround,
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor:
                                                    btnColor
                                                        .withOpacity(
                                                        0.1),
                                                    child: Icon(
                                                        Icons.date_range,
                                                        color: btnColor),
                                                  ),
                                                  Text(lastDate,
                                                      style: TxtStls
                                                          .fieldstyle),
                                                ],
                                              )),
                                          Container(
                                            color: Color(0xFFE0E0E0),
                                            height: 40,
                                            width: 1,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: 50,
                                            child: widget.list[index]
                                                .yes ==
                                                true
                                                ? InkWell(
                                                onTap: () {},
                                                onHover: (value) {
                                                  _isHover[7] = value;
                                                  setState(() {});
                                                },
                                                child: CircleAvatar(
                                                    backgroundColor:
                                                    btnColor
                                                        .withOpacity(
                                                        0.2),
                                                    child: _isHover[7]
                                                        ? Lottie.asset(
                                                        "assets/Lotties/success.json",
                                                        reverse:
                                                        true)
                                                        : Image.asset(
                                                        "assets/Images/success.png")))
                                                : InkWell(
                                                onTap: () {},
                                                onHover: (value) {
                                                  _isHover[8] = value;
                                                  setState(() {});
                                                },
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                  btnColor
                                                      .withOpacity(
                                                      0.1),
                                                  child: _isHover[8]
                                                      ? Lottie.asset(
                                                      "assets/Lotties/fail.json",
                                                      reverse:
                                                      true)
                                                      : SizedBox(
                                                    height: 30,
                                                    width: 30,
                                                    child: Image
                                                        .network(
                                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDEsuB-R1e4XmwavhpVzH1RxhZPQSj1XcLAA&usqp=CAU",
                                                      fit: BoxFit
                                                          .fill,
                                                    ),
                                                  ),
                                                )),
                                          )
                                        ],
                                      ),
                                      Container(
                                        height: size.height * 0.001,
                                        color: Color(0xFFE0E0E0),
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceEvenly,
                                              children: [
                                                Text("From",
                                                    style: TxtStls
                                                        .fieldstyle),
                                                Container(
                                                  alignment:
                                                  Alignment.center,
                                                  width: 120,
                                                  padding:
                                                  EdgeInsets.all(4.0),
                                                  decoration:
                                                  BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius
                                                            .circular(
                                                            10.0)),
                                                    color: FlagService
                                                        .stateClr(
                                                        statecolor),
                                                  ),
                                                  child: Text(
                                                      widget.list[index]
                                                          .from,
                                                      style: TxtStls
                                                          .fieldstyle1),
                                                ),
                                                Text("TO",
                                                    style: TxtStls
                                                        .fieldstyle),
                                                Container(
                                                  padding:
                                                  EdgeInsets.all(4.0),
                                                  width: 120,
                                                  alignment:
                                                  Alignment.center,
                                                  decoration:
                                                  BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius
                                                            .circular(
                                                            10.0)),
                                                    color: FlagService
                                                        .stateClr1(
                                                        statecolor1),
                                                  ),
                                                  child: Text(
                                                      widget.list[index]
                                                          .to,
                                                      style: TxtStls
                                                          .fieldstyle1),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            color: Color(0xFFE0E0E0),
                                            height: 40,
                                            width: 1,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceEvenly,
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor:
                                                    btnColor
                                                        .withOpacity(
                                                        0.1),
                                                    child: Icon(
                                                        Icons
                                                            .videogame_asset,
                                                        color: btnColor),
                                                  ),
                                                  Container(
                                                    padding:
                                                    EdgeInsets.all(
                                                        4.0),
                                                    alignment:
                                                    Alignment.center,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                        color: widget.list[
                                                        index]
                                                            .bound ==
                                                            "InBound"
                                                            ? goodClr
                                                            : flwClr,
                                                        borderRadius: BorderRadius
                                                            .all(Radius
                                                            .circular(
                                                            10.0))),
                                                    child: Text(
                                                      widget.list[index]
                                                          .bound,
                                                      style: TxtStls
                                                          .fieldstyle1,
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                    EdgeInsets.all(
                                                        4.0),
                                                    alignment:
                                                    Alignment.center,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: clr(
                                                            widget.list[
                                                            index]
                                                                .action),
                                                        borderRadius: BorderRadius
                                                            .all(Radius
                                                            .circular(
                                                            10.0))),
                                                    child: Text(
                                                        widget.list[
                                                        index]
                                                            .action,
                                                        style: TxtStls
                                                            .fieldstyle1),
                                                  ),
                                                ]),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(8.0),
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Text("Notes : ",
                                                      style: TxtStls
                                                          .fieldstyle),
                                                  Container(
                                                    alignment: Alignment
                                                        .centerLeft,
                                                    child: Text(
                                                      widget.list[index]
                                                          .who,
                                                      style: TxtStls
                                                          .fieldstyle,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              alignment:
                                              Alignment.centerLeft,
                                            ),
                                            Card(
                                              shape:
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(
                                                        10.0)),
                                              ),
                                              elevation: 10,
                                              child: Container(
                                                  padding:
                                                  EdgeInsets.only(
                                                      left: 10),
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  height: 100,
                                                  width:
                                                  size.width * 0.35,
                                                  child: Text(
                                                      widget.list[index]
                                                          .note,
                                                      style: TxtStls
                                                          .notestyle)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Color clr(action) {
    if (action == "CALL") {
      return wonClr;
    } else if (action == "EMAIL") {
      return avgClr;
    } else if (action == "SOCIAL MEDIA") {
      return btnColor;
    } else {
      return clsClr;
    }
  }
  Widget service(e, id) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        padding: const EdgeInsets.only(left: 5.0),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            color: neClr),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                e,
                style: TxtStls.fieldstyle1,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.cancel,
                color: bgColor,
                size: 15,
              ),
              onPressed: () {
                Provider.of<RemoveServiceProvider>(context,listen: false).removeService(id, e);
              },
            )
          ],
        ),
      ),
    );
  }
  Widget tab3() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: deco,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 2,
              ),
              child: TextFormField(
                controller: _paymentController,
                maxLines: 5,
                style: TxtStls.fieldstyle,
                decoration: InputDecoration(
                  hintText: "Enter a valid Comment",
                  hintStyle: TxtStls.fieldstyle,
                  border: InputBorder.none,
                ),
                validator: (fullname) {
                  if (fullname!.isEmpty) {
                    return "Name can not be empty";
                  } else if (fullname.length < 3) {
                    return "Name should be atleast 3 letters";
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: btnColor.withOpacity(0.1),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_rounded, color: btnColor),
                    onPressed: () {
                      _controller!.animateTo(_selectedIndex -= 1);
                    },
                  ),
                ),
                MaterialButton(
                  color: btnColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Text(
                    "Save",
                    style: TxtStls.fieldstyle1,
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<ActivityModel> activitylist1 =[] ;
  dateTimeRangePicker() async {
    DateTimeRange? picked = await showDateRangePicker(
      builder: (BuildContext context, Widget ?child) {
        return Theme(
          data: ThemeData(
            primarySwatch: Colors.grey,
            splashColor: Colors.black,
            textTheme: TextTheme(
              subtitle1: TextStyle(color: Colors.black),
              button: TextStyle(color: Colors.black),
            ),
            accentColor: Colors.black,
            colorScheme: ColorScheme.light(
                primary: btnColor,
                primaryVariant: Colors.black,
                secondaryVariant: Colors.black,
                onSecondary: Colors.black,
                onPrimary: Colors.white,
                surface: Colors.black,
                onSurface: Colors.black,
                secondary: Colors.black),
            dialogBackgroundColor: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400, maxHeight: 450),
                child: child,
              )
            ],
          ),
        );
      }
      context: context,
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      date1 = picked.start.toString().split(" ")[0];
      date2 = picked.end.toString().split(" ")[0];
      setState(() {
        Provider.of<ActivityProvider1>(context,listen: false).getAllActivitys1(widget.Idocid.toString(),picked.start.toString().split(" ")[0],picked.end.toString().split(" ")[0]).then((value) {


            setState(() {
              activitylist1 =
                  Provider.of<ActivityProvider1>(context,listen: false).activitymodellist1;
            });
          });


      });
    }
  }
}
