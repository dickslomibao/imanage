import 'package:imanage/services/firebase_todo_list_firestore.dart';

class Todo {
  String id;
  String title;
  String desc;
  dynamic startDate;
  bool isFinish;
  Todo({
    this.id = "",
    required this.title,
    required this.desc,
    required this.startDate,
    this.isFinish = false,
  });
  Map<String, dynamic> toMap() => {
        todoFirestore.title: title,
        todoFirestore.desc: desc,
        todoFirestore.startDate: startDate,
        todoFirestore.status: isFinish,
        'date_created': DateTime.now(),
      };
}
