import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one/shared/components/components.dart';
import 'package:project_one/shared/components/constants.dart';
import 'package:project_one/shared/cubit/cubit.dart';
import 'package:project_one/shared/cubit/states.dart';

class NewTasksScreen extends StatelessWidget {
  // final List<Map> tasks;
  const NewTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, state) {
        var tasks = AppCubit.get(context).tasks;

        return ListView.separated(
          itemBuilder: (context, index) => buildTaskItem(tasks[index]),
          separatorBuilder: (context, index) => Container(
            color: Colors.grey[400],
            height: 1,
          ),
          itemCount: tasks.length,
        );
      },
    );
  }
}
