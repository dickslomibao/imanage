import 'package:flutter/material.dart';
import 'package:imanage/utils/palette.dart';
import 'package:imanage/view/widgets/todos_form_widget.dart';

class HomeViewModel {
  String? validateForm({
    required String title,
    required String desc,
    required String startDate,
  }) {
    if (title == "") {
      return "Title is required.";
    }
    if (desc == "") {
      return "Description is required.";
    }
    if (startDate == "") {
      return "Startdate is required.";
    }
    return null;
  }

  bool isOngoing(dynamic date) {
    return date <= DateTime.now().microsecondsSinceEpoch;
  }

  void showModal(
      {required BuildContext context,
      dynamic data,
      required Function popLoader}) {
    showModalBottomSheet(
      backgroundColor: primaryBgColor,
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
        ),
      ),
      builder: (_) => AddEditTaskFormWidget(
        data: data,
        add: popLoader,
      ),
    );
  }
}

HomeViewModel homeViewModel = HomeViewModel();
