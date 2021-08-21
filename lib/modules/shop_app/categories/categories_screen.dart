import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one/layout/shop_app/cubit/cubit.dart';
import 'package:project_one/layout/shop_app/cubit/states.dart';
import 'package:project_one/models/shop_app/categories_model.dart';
import 'package:project_one/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var cubit = ShopCubit.get(context);

        return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => categoryItemBuilder(cubit.categoriesModel!.data!.data![index]),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: cubit.categoriesModel!.data!.data!.length,
        );
      },
    );
  }

  Widget categoryItemBuilder(DataModel dataModel) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(dataModel.image.toString()),
              width: 100,
              height: 100,
              // fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              dataModel.name.toString(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      );
}
