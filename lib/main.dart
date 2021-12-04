import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:project_one/layout/news_app/cubit/cubit.dart';
import 'package:project_one/layout/shop_app/cubit/cubit.dart';
import 'package:project_one/layout/shop_app/shop_layout.dart';
import 'package:project_one/layout/social_app/social_layout.dart';
import 'package:project_one/layout/todo_app/cubit/cubit.dart';
import 'package:project_one/layout/todo_app/cubit/states.dart';
import 'package:project_one/modules/shop_app/login/shop_login_screen.dart';
import 'package:project_one/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:project_one/modules/social_app/social_login/social_login_screen.dart';
import 'package:project_one/shared/bloc_observer.dart';
import 'package:project_one/shared/components/constants.dart';
import 'package:project_one/shared/network/local/cache_helper.dart';
import 'package:project_one/shared/network/remote/dio_helper.dart';
import 'package:project_one/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = await CacheHelper.getData("isDark");
  bool? onBoarding = await CacheHelper.getData("onBoarding");
  token = await CacheHelper.getData("token") ?? "";
  var uId = CacheHelper.getData("uId");

  Widget widget;

  if (onBoarding != null) {
    if (token.isEmpty)
      widget = ShopLoginScreen();
    else
      widget = ShopLayout();
  } else {
    widget = OnBoardingScreen();
  }

  // if(uId != null) {
  //   widget = SocialLayout();
  // } else {
  //   widget = SocialLoginScreen();
  // }

  runApp(MyApp(
    isDark: isDark ?? false,
    startWidget: widget,
  ));
}

//class MyApp
class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  MyApp({
    required this.isDark,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..getBusinessNews()),
        BlocProvider(
            create: (context) => AppCubit()..changeMode(fromShared: isDark)),
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavorites()
            ..getUserProfileData(),
        )
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: (AppCubit.get(context).isDark)
                ? ThemeMode.dark
                : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
