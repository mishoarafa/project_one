import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one/layout/news_app/cubit/cubit.dart';
import 'package:project_one/layout/news_app/cubit/states.dart';
import 'package:project_one/shared/components/components.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var sportsList = NewsCubit.get(context).sports;

        if (sportsList.length > 0) {
          return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildArticleItem(context, sportsList[index]),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: sportsList.length,
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
