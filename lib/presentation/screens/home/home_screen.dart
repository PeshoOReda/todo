import 'package:flutter/material.dart';
import 'package:todo/presentation/screens/home/tabs/settings_tab/settings_tab.dart';
import 'package:todo/presentation/screens/home/tabs/tasks_tab/tasks_tab.dart';

import '../../../l10n/app_localizations.dart';
import 'add_task_bottom_sheet/add_task_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<TasksTabState> tasksTabKey = GlobalKey();
  int currentIndex = 0;
  List<Widget> tabs = [];

  @override
  void initState() {
    super.initState();
    tabs = [
      TasksTab(
        key: tasksTabKey,
      ),
      const SettingsTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.title),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: buildFab(),
      bottomNavigationBar: buildBottomNavBar(),
      body: tabs[currentIndex],
    );
  }

  Widget buildBottomNavBar() => ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        child: BottomAppBar(
          notchMargin: 8,
          child: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (tappedIndex) {
                currentIndex = tappedIndex;
                setState(() {});
              },
              items: [
                BottomNavigationBarItem(
                    icon: const Icon(Icons.list),
                    label: AppLocalizations.of(context)!.tasks),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.settings_outlined),
                    label: AppLocalizations.of(context)!.settings),
              ]),
        ),
      );

  Widget buildFab() => FloatingActionButton(
        onPressed: () async {
          await AddTaskBottomSheet.show(context);
          // access reading data from firestore
          tasksTabKey.currentState?.getTodosFromFireStore();
        },
        child: const Icon(
          Icons.add,
        ),
      );
}
