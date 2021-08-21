import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one/models/shop_app/search_model.dart';
import 'package:project_one/modules/shop_app/search/cubit/states.dart';
import 'package:project_one/shared/components/constants.dart';
import 'package:project_one/shared/network/end_points.dart';
import 'package:project_one/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  //Search Products (POST)
  SearchModel searchModel = SearchModel();
  void search(String text) {
    emit(SearchLoadingState());

    //POST Data
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        "text": text,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print("******* Search Model: " + searchModel.data.toString());
      emit(SearchSuccessState());
    }).catchError((error) {
      print("******* Search Error: " + error.toString());
      emit(SearchErrorState());
    });
  }
}
