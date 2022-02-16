import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_web_app/BlockStateManagements/2FirebaseRepos/LeadsRepository.dart';

class Repository {
  ShowLeadsRepo showLeadsRepo = ShowLeadsRepo();
  Future<QuerySnapshot<Map<String, dynamic>>> getshowleaddata() =>
      showLeadsRepo.showLeads();
}
