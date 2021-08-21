import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project_one/layout/shop_app/cubit/cubit.dart';
import 'package:project_one/layout/shop_app/cubit/states.dart';
import 'package:project_one/models/shop_app/categories_model.dart';
import 'package:project_one/models/shop_app/home_model.dart';
import 'package:project_one/shared/components/components.dart';
import 'package:project_one/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    print("********** Height Of Screen is: " + height.toString());
    var ratio = height / 5;

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {
        if (state is ShopChangeFavoritesSuccessState &&
            !ShopCubit.get(context).changeFavoritesModel!.status!) {
          showToast(
              message: ShopCubit.get(context).changeFavoritesModel!.message!,
              state: ToastStates.ERROR);
        }
      },
      builder: (BuildContext context, state) {
        var cubit = ShopCubit.get(context);

        if (cubit.homeModel != null && cubit.categoriesModel != null) {
          return productsBuilder(
              context, cubit.homeModel, cubit.categoriesModel);
        } else {
          return Center(child: SpinKitFadingCircle(
            color: defaultColor,
          ));
        }
      },
    );
  }

  Widget productsBuilder(
          context, HomeModel? model, CategoriesModel? categoriesModel) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model!.data.banners
                  .map((e) => Image(
                        image: NetworkImage(e.image),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height / 4,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 0.9,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 7.7,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => categoryItemBuilder(
                          context, categoriesModel!.data!.data![index]),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 8,
                      ),
                      itemCount: categoriesModel!.data!.data!.length,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "New Products",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 1 / 1.67,
                children: List.generate(
                  model.data.products.length,
                  (index) =>
                      productGridBuilder(context, model.data.products[index]),
                ),
              ),
            ),
          ],
        ),
      );

  Widget productGridBuilder(context, ProductModel productModel) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(productModel.image),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 4,
                ),
                if (productModel.discount != 0)
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
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productModel.name,

                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                    ),
                  ),
                  // Spacer(),
                  Row(
                    children: [
                      Text(
                        productModel.price.round().toString(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (productModel.discount != 0)
                        Text(
                          productModel.oldPrice.round().toString(),
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
                              .changeFavorites(productModel.id);
                        },
                        icon: CircleAvatar(
                          radius: 15,
                          backgroundColor: (ShopCubit.get(context)
                                  .favorites[productModel.id])!
                              ? defaultColor
                              : Colors.grey[400],
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
          ],
        ),
      );

  Widget categoryItemBuilder(context, DataModel? dataModel) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(dataModel!.image.toString()),
            width: MediaQuery.of(context).size.height / 7.7,
            height: MediaQuery.of(context).size.height / 7.7,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.8),
            width: MediaQuery.of(context).size.height / 7.7,
            child: Text(
              dataModel.name.toString(),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
}
