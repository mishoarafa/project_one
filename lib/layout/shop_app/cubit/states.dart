import 'package:project_one/models/shop_app/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

//Get Home Data States
class ShopHomeDataLoadingState extends ShopStates {}
class ShopHomeDataSuccessState extends ShopStates {}
class ShopHomeDataErrorState extends ShopStates {}

//Get Categories States
class ShopCategoriesSuccessState extends ShopStates {}
class ShopCategoriesErrorState extends ShopStates {}

//Add or Remove Favorites States
class ShopChangeFavoritesState extends ShopStates {}
class ShopChangeFavoritesSuccessState extends ShopStates {}
class ShopChangeFavoritesErrorState extends ShopStates {}

//Get Favorites States
class ShopGetFavoritesLoadingState extends ShopStates {}
class ShopGetFavoritesSuccessState extends ShopStates {}
class ShopGetFavoritesErrorState extends ShopStates {}

//Profile States
class ShopUserProfileDataLoadingState extends ShopStates {}
class ShopUserProfileDataSuccessState extends ShopStates {
  final ShopLoginModel loginModel;
  ShopUserProfileDataSuccessState(this.loginModel);
}
class ShopUserProfileDataErrorState extends ShopStates {}

//Update Profile States
class ShopUpdateUserLoadingState extends ShopStates {}
class ShopUpdateUserSuccessState extends ShopStates {
  final ShopLoginModel loginModel;
  ShopUpdateUserSuccessState(this.loginModel);
}
class ShopUpdateUserErrorState extends ShopStates {}