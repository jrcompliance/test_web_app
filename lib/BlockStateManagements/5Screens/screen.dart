import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:test_web_app/BlockStateManagements/1Models/CovidModel.dart';
import 'package:test_web_app/BlockStateManagements/4Blocs/CovidBLoC.dart';
import 'package:test_web_app/Constants/reusable.dart';
import 'package:test_web_app/DashBoard/Comonents/Analytics/Analytics.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  CovidDataBloc covidDataBloc = CovidDataBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    covidDataBloc.fetchCoviddata();
  }

  @override
  void dispose() {
    covidDataBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BLOC PATTERN"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Analytics()));
              },
              icon: Icon(Icons.one_k))
        ],
      ),
      body: StreamBuilder(
        stream: covidDataBloc.CovidDataStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<CovidModel>> snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          if (!snapshot.hasData) {
            return SpinKitFadingCube(color: btnColor, size: 10);
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, index) {
              return ListTile(
                title: Text(snapshot.data![index].task.toString()),
                leading: Text(snapshot.data![index].CxID.toString()),
                subtitle: Text(
                    "Total Cases :" + snapshot.data![index].CxID.toString()),
              );
            },
          );
        },
      ),
    );
  }
}
