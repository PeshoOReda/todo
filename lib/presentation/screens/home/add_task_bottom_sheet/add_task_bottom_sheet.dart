import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/core/utils/date_ex/date_ex.dart';

import '../../../../core/utils/app_styles.dart';
import '../../../../database_manager/model/todo_dm.dart';
import '../../../../database_manager/model/user_dm.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();

  static Future show(context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: const AddTaskBottomSheet(),
          );
        });
  }
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDate = DateTime.now();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  List<int> arr = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      height: MediaQuery.of(context).size.height * .5,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add new task',
              textAlign: TextAlign.center,
              style: LightAppStyle.bottomSheetTitle,
            ),
            const SizedBox(height: 8),
            TextFormField(
              validator: (input) {
                if (input == null || input.trim().isEmpty) {
                  return 'Plz, enter task title';
                }
                return null;
              },
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'enter your task title',
                hintStyle: LightAppStyle.hint,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              validator: (input) {
                if (input == null || input.trim().isEmpty) {
                  return 'Plz, enter description';
                }
                if (input.length < 6) {
                  return 'Sorry, description should be at least 6 chars';
                }
                return null;
              },
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: 'enter your task description',
                hintStyle: LightAppStyle.hint,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Select date',
              style: LightAppStyle.date,
            ),
            InkWell(
              onTap: () {
                showTaskDate(context);
              },
              child: Text(
                selectedDate.toFormattedDate,
                textAlign: TextAlign.center,
                style: LightAppStyle.hint,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                addTaskToFireStore();
              },
              child: const Text(
                'Add task',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showTaskDate(context) async {
    selectedDate = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          initialDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(
            days: 365,
          )),
        ) ??
        selectedDate;

    setState(() {});
  }

  void addTaskToFireStore() {
    // form is valid
    if (formKey.currentState!.validate() == false) return;

    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection(UserDM.collectionName);
    CollectionReference todoCollection = usersCollection
        .doc(UserDM.currentUser!.id)
        .collection(TodoDM.collectionName);
    DocumentReference documentReference = todoCollection.doc(); // auto id

    TodoDM todo = TodoDM(
        id: documentReference.id,
        title: titleController.text,
        description: descriptionController.text,
        dateTime: selectedDate.copyWith(
          second: 0,
          millisecond: 0,
          minute: 0,
          microsecond: 0,
          hour: 0,
        ),
        isDone: false);
    documentReference
        .set(todo.toFireStore())
        .then(
          (_) {
            if (mounted) {
              Navigator.pop(context);
            }
          },
        )
        .onError(
          (error, stackTrace) {},
        )
        .timeout(
          const Duration(seconds: 4),
          onTimeout: () {
            if (mounted) {
              Navigator.pop(context);
            }
          },
        );
  }
}
