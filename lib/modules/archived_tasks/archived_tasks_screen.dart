import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one/shared/components/components.dart';
import 'package:project_one/shared/cubit/cubit.dart';
import 'package:project_one/shared/cubit/states.dart';

class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var tasks = AppCubit.get(context).archivedTasks;

        if (tasks.length == 0) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.archive,
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
