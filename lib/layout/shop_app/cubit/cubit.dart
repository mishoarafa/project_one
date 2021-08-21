import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one/layout/shop_app/cubit/states.dart';
import 'package:project_one/models/shop_app/categories_model.dart';
import 'package:project_one/models/shop_app/change_favorites_model.dart';
import 'package:project_one/models/shop_app/favorites_model.dart';
import 'package:project_one/models/shop_app/home_model.dart';
import 'package:project_one/models/shop_app/login_model.dart';
import 'package:project_one/modules/shop_app/categories/categories_screen.dart';
import 'package:project_one/modules/shop_app/favorites/favorites_screen.dart';
import 'package:project_one/modules/shop_app/products/products_screen.dart';
import 'package:project_one/modules/shop_app/settings/settings_screen.dart';
import 'package:project_one/shared/components/components.dart';
import 'package:project_one/shared/components/constants.dart';
import 'package:project_one/shared/network/end_points.dart';
import 'package:project_one/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  int currentIndex = 0;
  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  Map<int, bool> favorites = {};

  //Get Home Data (GET)
  HomeModel? homeModel;
  void getHomeData() {
    emit(ShopHomeDataLoadingState());

    //GET Data
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // print("************* Home Model: " + shopHomeModel.toString());
      // printFullText("************* Home Model Image: " + homeModel!.data.banners[0].image.toString());
      // printFullText("************* Home Model Status: " + homeModel!.status.toString());
      homeModel!.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });

      print("********* Favorites: " + favorites.toString());

      emit(ShopHomeDataSuccessState());
    }).catchError((error) {
      print("******* Error: " + error.toString());
      emit(ShopHomeDataErrorState());
    });
  }

  //Get Categories (GET)
  CategoriesModel? categoriesModel = CategoriesModel();
  void getCategories() {
    //GET Data
    DioHelper.getData(
      url: CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopCategoriesSuccessState());
    }).catchError((error) {
      print("******* Error: " + error.toString());
      emit(ShopCategoriesErrorState());
    });
  }

  //Add or Remove Favorites with product_id (POST)
  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());

    //POST Data
    DioHelper.postData(
      url: FAVORITES,
      data: {
        "product_id" : productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);

      if (!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }

      emit(ShopChangeFavoritesSuccessState());
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopChangeFavoritesErrorState());
    });
  }

  //Get Favorites (GET)
  FavoritesModel favoritesModel = FavoritesModel();
  void getFavorites() {
    emit(ShopGetFavoritesLoadingState());

    //GET Data
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      // printFullText("********* Favorites Model: " + value.data.toString());

      emit(ShopGetFavoritesSuccessState());
    }).catchError((error) {
      print("******* Error: " + error.toString());
      emit(ShopGetFavoritesErrorState());
    });
  }

  //Get Profile Data (GET)
  ShopLoginModel userModel = ShopLoginModel();
  void getUserProfileData() {
    emit(ShopUserProfileDataLoadingState());

    //GET Data
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print("********* Profile Model: " + value.data.toString());

      emit(ShopUserProfileDataSuccessState(userModel));
    }).catchError((error) {
      print("******* Error: " + error.toString());
      emit(ShopUserProfileDataErrorState());
    });
  }

  void updateUserProfileData({
  required String name,
  required String email,
  required String phone,
}) {
    emit(ShopUpdateUserLoadingState());

    //GET Data
    DioHelper.putData(
      url: UPDATE_PROFILE,
      data: {
        "name" : name,
        "phone" : phone,
        "email" : email,
      },
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print("********* Profile Model: " + value.data.toString());

      emit(ShopUpdateUserSuccessState(userModel));
    }).catchError((error) {
      print("******* Error: " + error.toString());
      emit(ShopUpdateUserErrorState());
    });
  }
}
