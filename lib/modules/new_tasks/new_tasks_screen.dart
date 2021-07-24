import 'package:flutter/material.dart';
import 'package:project_one/shared/components/components.dart';
import 'package:project_one/shared/components/constants.dart';

class NewTasksScreen extends StatelessWidget {
  // final List<Map> tasks;
  const NewTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => buildTaskItem(tasks[index]),
      separatorBuilder: (context, index) => Container(
        color: Colors.grey[400],
        height: 1,
      ),
      itemCount: tasks.length,
    );
  }
}
