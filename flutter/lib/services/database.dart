import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_yoklama/models/student.dart';
import 'package:online_yoklama/services/firestore_service.dart';

abstract class Database {
  Stream<QuerySnapshot> listenStudentStream();
  Stream<List<Student>> listenStudentListStream();
}

class OnlineYoklamaDatabase implements Database {
  final _service = FirestoreService.instance;

  @override
  Stream<QuerySnapshot> listenStudentStream() =>
      FirebaseFirestore.instance.collection("users").snapshots();

  @override
  Stream<List<Student>> listenStudentListStream() {
    return _service.collectionStream(
        path: "users", builder: (data, studentID) => Student.fromMap(data));
  }
}
