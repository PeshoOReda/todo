import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/utils/colors_manager.dart';
import '../../../../../../database_manager/model/todo_dm.dart';
import '../../../../../../database_manager/model/user_dm.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../add_task_bottom_sheet/edit_task_page.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({super.key, required this.todo, required this.onDeletedTask});

  final TodoDM todo;
  final Function onDeletedTask;

  @override
  TodoItemState createState() => TodoItemState();
}

class TodoItemState extends State<TodoItem> {
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.onPrimary),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: .3,
          motion: const BehindMotion(),
          children: [
            SlidableAction(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15)),
              flex: 2,
              onPressed: (context) {
                deleteTodoFromFireStore(widget.todo);
                widget.onDeletedTask();
              },
              backgroundColor: ColorsManager.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.deleteTask,
            ),
          ],
        ),
        endActionPane: ActionPane(
            extentRatio: 0.3,
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                flex: 2,
                onPressed: (context) {
                  showDialog(
                    context: context,
                    builder: (context) => EditTaskPage(todo: widget.todo),
                  );
                },
                backgroundColor: ColorsManager.blue,
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: AppLocalizations.of(context)!.edit,
              ),
            ]),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Container(
                height: 62,
                width: 4,
                decoration: BoxDecoration(
                  color: ColorsManager.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(
                width: 7,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.todo.title,
                    style: isDone
                        ? LightAppStyle.todoTitle
                            .copyWith(color: Colors.blueAccent)
                        : LightAppStyle.todoTitle,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.todo.description,
                    style: isDone
                        ? LightAppStyle.todoDesc
                            .copyWith(color: Colors.blueAccent)
                        : LightAppStyle.todoDesc,
                  ),
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  updateTodoStatus(widget.todo);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                      color: ColorsManager.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: isDone
                      ? const Text(
                          'Done',
                          style: TextStyle(color: ColorsManager.white),
                        )
                      : const Icon(
                          Icons.check,
                          color: ColorsManager.white,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteTodoFromFireStore(TodoDM todo) async {
    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(UserDM.currentUser!.id)
        .collection(TodoDM.collectionName);
    DocumentReference todoDoc = todoCollection.doc(todo.id);
    await todoDoc.delete();
  }

  void updateTodoStatus(TodoDM todo) async {
    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(UserDM.currentUser!.id)
        .collection(TodoDM.collectionName);
    DocumentReference todoDoc = todoCollection.doc(todo.id);
    await todoDoc.update({'isDone': true});
    setState(() {
      isDone = true;
    });
  }
}
