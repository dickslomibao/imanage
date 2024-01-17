import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imanage/services/firebase_authetication.dart';
import 'package:imanage/utils/palette.dart';
import 'package:imanage/utils/text_util.dart';
import 'package:imanage/view/widgets/all_todos_widget.dart';
import 'package:imanage/view/widgets/completed_widget.dart';
import 'package:imanage/view/widgets/incoming_task_widget.dart';
import 'package:imanage/view/widgets/logo_text_widget.dart';
import 'package:imanage/view/widgets/logo_widget.dart';
import 'package:imanage/view/widgets/ongoing_todos_widget.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:imanage/view/widgets/todays_task_widget.dart';
import 'package:imanage/view_model/home_vmode.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const LogoWidget(),
                  const LogoTextWidget(),
                  authServices.userProvideIsGoogle()
                      ? GestureDetector(
                          onTap: () async {
                            await FirebaseAuth.instance.signOut();
                            await authServices.signOut();
                            if (context.mounted) {
                              context.goNamed('splash');
                            }
                          },
                          child: const Icon(
                            Icons.logout,
                            color: txtColor,
                          ),
                        )
                      : GestureDetector(
                          onTap: () async {
                            context.goNamed('profile');
                          },
                          child: const Icon(
                            Icons.settings_outlined,
                            color: txtColor,
                          ),
                        ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.goNamed('selectavatar');
                    },
                    child: CircleAvatar(
                      radius: 27,
                      child: Image.network(
                        FirebaseAuth.instance.currentUser!.photoURL ?? "",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        txtLabel('Hello,'),
                        txtSubHeader(
                          "${FirebaseAuth.instance.currentUser?.displayName}",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const TodayTodosWidget(),
              Align(
                alignment: Alignment.center,
                child: TabBar(
                  indicatorColor: btnBgColor,
                  isScrollable: true,
                  controller: _tabController,
                  tabs: const [
                    Tab(
                      text: "All task",
                      icon: FaIcon(
                        FontAwesomeIcons.listCheck,
                        size: 16,
                        color: Colors.blue,
                      ),
                    ),
                    Tab(
                      text: "Ongoing task",
                      icon: FaIcon(
                        FontAwesomeIcons.barsProgress,
                        size: 16,
                        color: Colors.pink,
                      ),
                    ),
                    Tab(
                      text: "Incoming task",
                      icon: FaIcon(
                        FontAwesomeIcons.calendarPlus,
                        size: 16,
                        color: Colors.red,
                      ),
                    ),
                    Tab(
                      text: "Completed task",
                      icon: FaIcon(
                        FontAwesomeIcons.checkDouble,
                        size: 16,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    AllTodosWidget(),
                    OngoingTaskWidget(),
                    IncomingTask(),
                    CompletedScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: btnBgColor,
        onPressed: () {
          homeViewModel.showModal(
              context: context,
              popLoader: () {
                Navigator.of(context).pop();
                EasyLoading.showToast(
                  'Task added.',
                  toastPosition: EasyLoadingToastPosition.bottom,
                );
              });
        },
        child: const FaIcon(
          FontAwesomeIcons.plus,
        ),
      ),
    );
  }
}
