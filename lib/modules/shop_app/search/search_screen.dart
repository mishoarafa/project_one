import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:project_one/layout/shop_app/cubit/cubit.dart';
import 'package:project_one/models/shop_app/search_model.dart';
import 'package:project_one/modules/shop_app/search/cubit/cubit.dart';
import 'package:project_one/modules/shop_app/search/cubit/states.dart';
import 'package:project_one/shared/components/components.dart';
import 'package:project_one/shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  var searchFormKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          var cubit = SearchCubit.get(context);
          double height = MediaQuery.of(context).size.height / 6;

          return Scaffold(
            appBar: AppBar(
              title: Text("Search"),
            ),
            body: Form(
              key: searchFormKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    defaultFormField(
                      controller: searchController,
                      text: "Search",
                      textWeight: FontWeight.bold,
                      prefixIcon: Icons.search,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Data to Start Search";
                        }
                        return null;
                      },
                      onSubmit: (value) {
                        if (searchFormKey.currentState!.validate()) {
                          cubit.search(value);
                        }
                      },
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    if (state is SearchLoadingState)
                      Expanded(
                        child: Center(
                          child: JumpingText(
                            "Loading...",
                            style: TextStyle(
                              color: defaultColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return buildSearchItem(context, height,
                                cubit.searchModel.data!.data![index]);
                          },
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: cubit.searchModel.data!.data!.length,
                        ),
                      ),
                    if (state is !SearchLoadingState && state is !SearchSuccessState)
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
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
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSearchItem(context, height, Product product) => Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 14,
          bottom: 14,
          end: 14,
          top: 5,
        ),
        child: Container(
          height: height,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(product.image!),
                    width: height,
                    height: height,
                  ),
                  // if (product.discount != 0)
                  //   Container(
                  //     color: Colors.red,
                  //     padding: EdgeInsets.symmetric(
                  //       horizontal: 5,
                  //     ),
                  //     child: Text(
                  //       "DISCOUNT",
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 10,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Column(
                    children: [
                      Text(
                        product.name!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          height: 1.4,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            product.price.round().toString(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: defaultColor,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          // if (product.discount != 0)
                          //   Text(
                          //     product.oldPrice.round().toString(),
                          //     style: TextStyle(
                          //       fontSize: 10,
                          //       fontWeight: FontWeight.bold,
                          //       color: Colors.grey,
                          //       decoration: TextDecoration.lineThrough,
                          //     ),
                          //   ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              ShopCubit.get(context)
                                  .changeFavorites(product.id!);
                            },
                            icon: CircleAvatar(
                              radius: 15,
                              backgroundColor: (ShopCubit.get(context)
                                          .favorites[product.id] ??
                                      false)
                                  ? defaultColor
                                  : Colors.grey,
                              child: Icon(
                                Icons.favorite_border,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
