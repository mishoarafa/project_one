import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one/layout/news_app/cubit/states.dart';
import 'package:project_one/modules/news_app/business/business_screen.dart';
import 'package:project_one/modules/news_app/science/science_screen.dart';
import 'package:project_one/modules/news_app/sports/sports_screen.dart';
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
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];
  String webViewPageTitle = "";

  void changeIndex(index) {
    currentIndex = index;
    if (index == 1) {
      getSportsNews();
    }
    if (index == 2) {
      getScienceNews();
    }
    emit(NewsBottomNavIndexChangeState());
    print("******* Index: " + index.toString());
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
      business = value.data["articles"];

      emit(NewsGetBusinessSuccessState());
      print(business.length);
    }).catchError((error) {
      emit(NewsGetBusinessErrorState(error.toString()));
      print("******** Error: " + error.toString());
    });
  }

  void getSportsNews() {
    emit(NewsGetSportsLoadingState());

    if (sports.length == 0) {
      DioHelper.getData(
        url: "v2/top-headlines",
        query: {
          "country": "eg",
          "category": "sports",
          "apiKey": "0fa74e6983e3471fae50a3704ee35a4d",
        },
      ).then((value) {
        sports = value.data["articles"];

        emit(NewsGetSportsSuccessState());
        print(sports.length);
      }).catchError((error) {
        emit(NewsGetSportsErrorState(error.toString()));
        print("******** Error: " + error.toString());
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  void getScienceNews() {
    emit(NewsGetScienceLoadingState());

    if (science.length == 0) {
      DioHelper.getData(
        url: "v2/top-headlines",
        query: {
          "country": "eg",
          "category": "science",
          "apiKey": "0fa74e6983e3471fae50a3704ee35a4d",
        },
      ).then((value) {
        science = value.data["articles"];

        emit(NewsGetScienceSuccessState());
        print(science.length);
      }).catchError((error) {
        emit(NewsGetScienceErrorState(error.toString()));
        print("******** Error: " + error.toString());
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  void getSearchResult(String value) {
    search = [];

    emit(NewsSearchLoadingState());

    DioHelper.getData(
      url: "v2/everything",
      query: {
        "q": "$value",
        "apiKey": "0fa74e6983e3471fae50a3704ee35a4d",
      },
    ).then((value) {
      search = value.data["articles"];

      emit(NewsSearchSuccessState());
      print(search.length);
    }).catchError((error) {
      emit(NewsSearchErrorState(error.toString()));
      print("******** Error: " + error.toString());
    });
  }

}
