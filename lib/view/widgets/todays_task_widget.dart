import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:imanage/services/firebase_todo_list_firestore.dart';
import 'package:imanage/utils/palette.dart';
import 'package:imanage/utils/text_util.dart';

class TodayTodosWidget extends StatelessWidget {
  const TodayTodosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: todoFirestore.todosToday(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: btnBgColor,
            ),
          );
        }
        if (snapshot.data!.size == 0) {
          return const SizedBox(
            height: 20,
          );
        }
        return SizedBox(
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              txtSubHeader("Today's task (${snapshot.data!.size})"),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.size,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final item = snapshot.data!.docs[index];
                    return Container(
                      padding: const EdgeInsets.all(24),
                      margin: const EdgeInsets.only(right: 20),
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromRGBO(0, 0, 0, .22),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 220,
                                    child: Text(
                                      '${item[todoFirestore.title]}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: txtColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await todoFirestore.setStatus(
                                          item.id, true);
                                      EasyLoading.showToast('Task completed',
                                          toastPosition:
                                              EasyLoadingToastPosition.bottom);
                                    },
                                    child: const Icon(
                                      Icons.check_box_outline_blank,
                                      color: btnBgColor,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${item[todoFirestore.desc]}',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: txtColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
    );
  }
}
