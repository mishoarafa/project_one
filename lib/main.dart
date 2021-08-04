import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:project_one/layout/news_app/cubit/cubit.dart';
import 'package:project_one/layout/todo_app/todo_layout.dart';
import 'package:project_one/modules/bmi_app/bmi/bmi_calculator_screen.dart';
import 'package:project_one/modules/counter_app/counter/counter_screen.dart';
import 'package:project_one/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:project_one/shared/bloc_observer.dart';
import 'package:project_one/shared/cubit/cubit.dart';
import 'package:project_one/shared/cubit/states.dart';
import 'package:project_one/shared/network/local/cache_helper.dart';
import 'package:project_one/shared/network/remote/dio_helper.dart';
import 'package:project_one/shared/styles/themes.dart';
import 'layout/news_app/news_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getBoolean("isDark");

  runApp(MyApp(isDark!));
}

//class MyApp
class MyApp extends StatelessWidget {
  final bool isDark;

  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..getBusinessNews()),
        BlocProvider(
            create: (context) => AppCubit()..changeMode(fromShared: isDark)),
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
            home: OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
