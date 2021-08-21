import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one/layout/news_app/cubit/cubit.dart';
import 'package:project_one/layout/news_app/cubit/states.dart';
import 'package:project_one/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var list = NewsCubit.get(context).search;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Search",
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: defaultFormField(
                  controller: searchController,
                  text: "Search",
                  prefixIcon: Icons.search,
                  onChanged: (String value) {
                    NewsCubit.get(context).getSearchResult(value);
                  },
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Search must not be empty";
                    }
                    return null;
                  },
                ),
              ),
              (list.length > 0)
                  ? Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            buildArticleItem(context, list[index]),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount: 10,
                      ),
                    )
                  : Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              size: 45,
                              color: Colors.grey[400],
                            ),
                            Text(
                              "Search",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
