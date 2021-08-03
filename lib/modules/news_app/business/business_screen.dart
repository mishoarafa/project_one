import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one/layout/news_app/cubit/cubit.dart';
import 'package:project_one/layout/news_app/cubit/states.dart';
import 'package:project_one/shared/components/components.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var businessList = NewsCubit.get(context).business;

        if (state is! NewsGetBusinessLoadingState) {
          return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildArticleItem(context, businessList[index]),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: businessList.length,
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
