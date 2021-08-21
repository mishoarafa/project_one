import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one/layout/todo_app/cubit/cubit.dart';
import 'package:project_one/layout/todo_app/cubit/states.dart';
import 'package:project_one/shared/components/components.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var tasks = AppCubit.get(context).doneTasks;

        if (tasks.length == 0) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.grey,
                  size: 50,
                ),
                SizedBox(height: 10,),
                Text(
                  "No Tasks",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          );
        } else {
          return ListView.separated(
            itemBuilder: (context, index) =>
                buildTaskItem(tasks[index], context),
            separatorBuilder: (context, index) => Container(
              color: Colors.grey[400],
              height: 1,
            ),
            itemCount: tasks.length,
          );
        }
      },
    );
  }
}
