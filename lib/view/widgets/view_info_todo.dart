import 'package:flutter/material.dart';
import 'package:imanage/services/firebase_todo_list_firestore.dart';
import 'package:imanage/utils/palette.dart';
import 'package:imanage/utils/text_util.dart';
import 'package:intl/intl.dart';

class ShowTodoInfoWidget extends StatelessWidget {
  const ShowTodoInfoWidget({super.key, required this.data});
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: primaryBgColor,
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            txtSubHeader('Title:'),
            txtSubHeader(data[todoFirestore.title]),
            const SizedBox(
              height: 10,
            ),
            txtSubHeader('Description:'),
            txtSubHeader(data[todoFirestore.desc]),
            const SizedBox(
              height: 10,
            ),
            txtSubHeader('Start date:'),
            txtSubHeader(DateFormat.yMMMEd().format(
                DateTime.fromMicrosecondsSinceEpoch(
                    data[todoFirestore.startDate]))),
          ],
        ),
      ),
    );
  }
}
