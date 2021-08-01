import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one/layout/new_app/cubit/states.dart';
import 'package:project_one/modules/business/business_screen.dart';
import 'package:project_one/modules/science/science_screen.dart';
import 'package:project_one/modules/settings/settings_screen.dart';
import 'package:project_one/modules/sports/sports_screen.dart';
import 'package:project_one/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: "Business",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: "Sports",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: "Science",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: "Settings",
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];

  List<dynamic> business = [];

  void changeIndex(index) {
    currentIndex = index;
    print("******* Index: " + index.toString());
    emit(NewsBottomNavIndexChangeState());
  }

  void getBusinessNews() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: "v2/top-headlines",
      query: {
        "country": "eg",
        "category": "business",
        "apiKey": "0fa74e6983e3471fae50a3704ee35a4d",
      },
    ).then((value) {
      // print("******Response : " + value.data.toString());
      business = value.data["articles"];

      emit(NewsGetBusinessSuccessState());
      print(business.length);
    }).catchError((error) {
      emit(NewsGetBusinessErrorState(error.toString()));
      print("******** Error: " + error.toString());
    });
  }
}
