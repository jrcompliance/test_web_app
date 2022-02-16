import 'package:test_web_app/BlockStateManagements/1Models/CovidModel.dart';
import 'package:test_web_app/BlockStateManagements/2FirebaseRepos/CovidApiRepo.dart';

class Repository {
  CovidApiRepo covidApiRepo = CovidApiRepo();
  Future<List<CovidModel>> getLatestCovidData() =>
      covidApiRepo.getLatestCovidData();
}
