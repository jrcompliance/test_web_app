import 'package:rxdart/rxdart.dart';
import 'package:test_web_app/BlockStateManagements/1Models/CovidModel.dart';
import 'package:test_web_app/BlockStateManagements/3Repositories/Repository.dart';
import 'package:test_web_app/Constants/Services.dart';

class CovidDataBloc {
  final repository = Repository();
  final coviddatafetcher = PublishSubject<List<CovidModel>>();

  Stream<List<CovidModel>> get CovidDataStream => coviddatafetcher.stream;

  fetchCoviddata() async {
    List<CovidModel> data = await repository.getLatestCovidData();
    coviddatafetcher.sink.add(data);
  }

  dispose() {
    coviddatafetcher.close();
  }
}
