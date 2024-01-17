import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:imanage/services/firebase_todo_list_firestore.dart';
import 'package:imanage/utils/palette.dart';
import 'package:imanage/view/widgets/alert_dialog_loader.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:imanage/view/widgets/view_info_todo.dart';
import 'package:imanage/view_model/home_vmode.dart';
import 'package:intl/intl.dart';

class TodoCardWigdet extends StatelessWidget {
  const TodoCardWigdet({
    super.key,
    required this.data,
    required this.popLoader,
    this.type = "",
  });
  final dynamic data;
  final Function popLoader;
  final String type;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromRGBO(0, 0, 0, 0),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) async {
                showDialog(
                  context: context,
                  builder: (_) => const LoaderWidget(),
                );
                await todoFirestore.deleteTodo(data.id).then((value) {
                  popLoader();
                  EasyLoading.showToast(
                    'Task deleted',
                    toastPosition: EasyLoadingToastPosition.bottom,
                  );
                });
              },
              backgroundColor: btnBgColor,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            if (type != 'completed')
              SlidableAction(
                onPressed: (context) {
                  homeViewModel.showModal(
                    context: context,
                    data: data,
                    popLoader: popLoader,
                  );
                },
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                icon: Icons.edit_document,
                label: 'Edit',
              ),
          ],
        ),
        key: ValueKey(data.id),
        child: ListTile(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return ShowTodoInfoWidget(
                  data: data,
                );
              },
            );
          },
          title: Text(
            data[todoFirestore.title],
            style: const TextStyle(
              color: txtColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Visibility(
            visible: type == 'ongoing' || type == 'completed',
            child: type == 'ongoing'
                ? IconButton(
                    icon: const Icon(
                      Icons.check_box_outline_blank,
                      color: Color.fromARGB(255, 58, 68, 59),
                    ),
                    onPressed: () async {
                      await todoFirestore.setStatus(data.id, true);
                      EasyLoading.showToast('Task completed',
                          toastPosition: EasyLoadingToastPosition.bottom);
                    },
                  )
                : IconButton(
                    icon: Icon(
                      Icons.check_box,
                      color: Colors.green.shade800,
                    ),
                    onPressed: () async {
                      await todoFirestore.setStatus(data.id, false);
                      EasyLoading.showToast('Task uncompleted',
                          toastPosition: EasyLoadingToastPosition.bottom);
                    },
                  ),
          ),
          subtitle: Text(
            type == 'incoming'
                ? "Start Date: ${DateFormat.yMMMEd().format(
                    DateTime.fromMicrosecondsSinceEpoch(
                      data[todoFirestore.startDate],
                    ),
                  )}"
                : data[todoFirestore.desc],
            style: const TextStyle(
              color: txtColor,
              fontSize: 15,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
