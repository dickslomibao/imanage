import 'package:flutter/material.dart';
import 'package:imanage/services/firebase_todo_list_firestore.dart';
import 'package:imanage/utils/palette.dart';
import 'package:imanage/utils/text_util.dart';
import 'package:imanage/view/widgets/todo_card_widget.dart';

class IncomingTask extends StatelessWidget {
  const IncomingTask({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: todoFirestore.incomingTask(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: btnBgColor,
              ),
            );
          }
          if (snapshot.data!.size == 0) {
            return Center(
              child: txtSubHeader('No incoming task yet.'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.size,
            itemBuilder: (_, index) {
              final data = snapshot.data!.docs[index];
              return TodoCardWigdet(
                data: data,
                type: 'incoming' ,
                popLoader: () {
                  Navigator.of(context).pop();
                },
              );
            },
          );
        });
  }
}
