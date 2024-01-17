import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:imanage/models/todo_model.dart';
import 'package:imanage/services/firebase_todo_list_firestore.dart';
import 'package:imanage/utils/date_picker.dart';
import 'package:imanage/utils/text_util.dart';
import 'package:imanage/validator/validator_alert_dialog.dart';
import 'package:imanage/view/widgets/alert_dialog_loader.dart';
import 'package:imanage/view/widgets/date_field_widget.dart';
import 'package:imanage/view/widgets/elvatedbutton_widget.dart';
import 'package:imanage/view/widgets/text_field_widget.dart';
import 'package:imanage/view_model/home_vmode.dart';
import 'package:intl/intl.dart';

class AddEditTaskFormWidget extends StatefulWidget {
  const AddEditTaskFormWidget({
    super.key,
    required this.add,
    this.data,
  });

  final Function add;
  final dynamic data;
  @override
  State<AddEditTaskFormWidget> createState() => _AddEditTaskFormWidgetState();
}

class _AddEditTaskFormWidgetState extends State<AddEditTaskFormWidget> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController descController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  dynamic actualDate;
  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      titleController.text = widget.data[todoFirestore.title];
      descController.text = widget.data[todoFirestore.desc];
      startDateController.text = DateFormat.yMMMEd().format(
        DateTime.fromMicrosecondsSinceEpoch(
          widget.data[todoFirestore.startDate],
        ),
      );
      actualDate = DateTime.fromMicrosecondsSinceEpoch(
        widget.data[todoFirestore.startDate],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            top: 24.0,
            right: 24,
            left: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            txtHeader(
                widget.data == null ? 'Create ' : 'Update' ' a To-do List'),
            const SizedBox(
              height: 20,
            ),
            TextFieldWidget(
              label: 'Title:',
              controller: titleController,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldWidget(
              label: 'Descriptions:',
              controller: descController,
            ),
            const SizedBox(
              height: 10,
            ),
            DateFieldWidget(
              label: 'Start Date:',
              controller: startDateController,
              onTap: () async {
                actualDate = await showDateBox(context);
                String date = DateFormat.yMMMEd().format(actualDate!);
                setState(() {
                  startDateController.text = date;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButtonWidget(
              onPressed: () async {
                String title = titleController.text.trim();
                String desc = descController.text.trim();
                String startDate = startDateController.text.trim();
                String? validate = homeViewModel.validateForm(
                  title: title,
                  desc: desc,
                  startDate: startDate,
                );
                if (validate != null) {
                  showError(context, validate);
                  return;
                }
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (_) => const LoaderWidget(),
                );
                if (widget.data == null) {
                  await todoFirestore
                      .add(
                    Todo(
                      title: title,
                      desc: desc,
                      startDate: actualDate.microsecondsSinceEpoch,
                    ),
                  )
                      .then(
                    (value) {
                      widget.add();
                      EasyLoading.showToast(
                        'Task added.',
                        toastPosition: EasyLoadingToastPosition.bottom,
                      );
                    },
                  );
                } else {
                  await todoFirestore
                      .update(
                    Todo(
                      id: widget.data.id,
                      title: title,
                      desc: desc,
                      startDate: actualDate.microsecondsSinceEpoch,
                    ),
                  )
                      .then(
                    (value) {
                      widget.add();
                      EasyLoading.showToast(
                        'Task Updated.',
                        toastPosition: EasyLoadingToastPosition.bottom,
                      );
                    },
                  );
                }
              },
              label: widget.data == null ? 'Add new todo ' : 'Save',
            ),
          ],
        ),
      ),
    );
  }
}
