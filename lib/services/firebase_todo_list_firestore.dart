import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imanage/models/todo_model.dart';
import 'package:imanage/services/firebase_authetication.dart';

class TodoFirestore {
  String title = "title";
  String desc = "desc";
  String startDate = "start_date";
  String status = "isFinish";
  final firestore = FirebaseFirestore.instance.collection('todos');
  Future<void> add(Todo todo) async {
    await firestore
        .doc(authServices.userUid())
        .collection('task')
        .add(todo.toMap());
  }

  Future<void> update(Todo todo) async {
    firestore
        .doc(authServices.userUid())
        .collection('task')
        .doc(todo.id)
        .update(todo.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> allTodos() {
    return firestore
        .doc(authServices.userUid())
        .collection('task')
        .orderBy(todoFirestore.startDate, descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> completedTodos() {
    return firestore
        .doc(authServices.userUid())
        .collection('task')
        .where(status, isEqualTo: true)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> todosToday() {
    return firestore
        .doc(authServices.userUid())
        .collection('task')
        .where(
          startDate,
          isEqualTo: DateTime(
                  DateTime.now().year, DateTime.now().month, DateTime.now().day)
              .microsecondsSinceEpoch,
        )
        .where(status, isEqualTo: false)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> ongoingTask() {
    return firestore
        .doc(authServices.userUid())
        .collection('task')
        .where(status, isEqualTo: false)
        .where(
          startDate,
          isLessThanOrEqualTo: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ).microsecondsSinceEpoch,
        )
        .orderBy(startDate)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> incomingTask() {
    return firestore
        .doc(authServices.userUid())
        .collection('task')
        .where(
          startDate,
          isGreaterThan: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ).microsecondsSinceEpoch,
        )
        .snapshots();
  }

  Future<void> deleteTodo(String id) async {
    await firestore
        .doc(authServices.userUid())
        .collection('task')
        .doc(id)
        .delete();
  }

  Future<void> setStatus(String id, bool value) async {
    await firestore
        .doc(authServices.userUid())
        .collection('task')
        .doc(id)
        .update({
      todoFirestore.status: value,
    });
  }
}

TodoFirestore todoFirestore = TodoFirestore();
