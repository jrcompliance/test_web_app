import 'package:rxdart/rxdart.dart';
import 'package:test_web_app/BlockStateManagements/1Models/ShowLeadsModel.dart';
import 'package:test_web_app/BlockStateManagements/3Repositories/Repository.dart';

class ShowLeadBloc {
  final _repository = Repository();

  final _showleadsfetcher = PublishSubject<List<ShowLeadsModel>>();

  Stream<List<ShowLeadsModel>> get shopleadstream => _showleadsfetcher.stream;

  fetchCoivdData() async {
    List<ShowLeadsModel> data =
        (await _repository.getshowleaddata()) as List<ShowLeadsModel>;
    _showleadsfetcher.sink.add(data);
  }

  dispose() {
    _showleadsfetcher.close();
  }
}

final showleadBloc = ShowLeadBloc();
