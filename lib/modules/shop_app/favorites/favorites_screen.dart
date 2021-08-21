import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one/layout/shop_app/cubit/cubit.dart';
import 'package:project_one/layout/shop_app/cubit/states.dart';
import 'package:project_one/models/shop_app/favorites_model.dart';
import 'package:project_one/shared/components/components.dart';
import 'package:project_one/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 6;

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var cubit = ShopCubit.get(context);

        if (state is ShopGetFavoritesLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (cubit.favoritesModel.data!.data!.length != 0) {
          return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return buildFavoriteItem(context, height,
                  cubit.favoritesModel.data!.data![index].product!);
            },
            separatorBuilder: (context, index) => myDivider(),
            itemCount: cubit.favoritesModel.data!.data!.length,
          );
        } else {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.favorite,
                  size: 45,
                  color: Colors.grey[400],
                ),
                Text(
                  "No Favorites",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget buildFavoriteItem(context, height, Product product) => Padding(
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
                  if (product.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      child: Text(
                        "DISCOUNT",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
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
                          if (product.discount != 0)
                            Text(
                              product.oldPrice.round().toString(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              ShopCubit.get(context)
                                  .changeFavorites(product.id!);
                            },
                            icon: CircleAvatar(
                              radius: 15,
                              backgroundColor: defaultColor,
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
