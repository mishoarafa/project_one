import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one/layout/news_app/cubit/cubit.dart';
import 'package:project_one/layout/news_app/cubit/states.dart';
import 'package:project_one/shared/components/components.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var scienceList = NewsCubit.get(context).science;

        if (scienceList.length > 0) {
          return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildArticleItem(context, scienceList[index]),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: scienceList.length,
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
