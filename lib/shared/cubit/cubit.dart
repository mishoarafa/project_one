import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:project_one/modules/done_tasks/done_tasks_screen.dart';
import 'package:project_one/modules/new_tasks/new_tasks_screen.dart';
import 'package:project_one/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  late Database db;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> titles = [
    "Tasks",
    "Done Tasks",
    "Archived Tasks",
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void createDB() {
    openDatabase(
      "todo.db",
      version: 1,
      onCreate: (database, version) {
        print("Database has been created successfully !!");
        database
            .execute(
                "CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)")
            .then((value) {
          print("Table has been created successfully !!");
        }).catchError((error) {
          print("Error while creating table: ${error.toString()}");
        });
      },
      onOpen: (database) {
        getDataFromDB(database);
        print("Database opened successfully !!");
      },
    ).then((value) {
      db = value;
      emit(AppCreateDBState());
    });
  }

  insertToDB(String title, String date, String time) async {
    await db.transaction((txn) async {
      txn
          .rawInsert(
              "INSERT INTO tasks(title, date, time, status) VALUES('$title', '$date', '$time', 'new')")
          .then((value) {
        print("$value inserted successfully");
        emit(AppInsertIntoDBState());

        getDataFromDB(db);
      }).catchError((error) {
        print("Error while inserting a record: ${error.toString()}");
      });
    });
  }

  void getDataFromDB(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    emit(AppGetDatabaseLoadingState());
    database.rawQuery("SELECT * FROM tasks").then((value) {
      print("**** TASKS: " + value.toString());

      value.forEach((element) {
        if (element["status"] == "new") {
          newTasks.add(element);
        } else if (element["status"] == "done") {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      });

      emit(AppGetFromDBState());
    });
  }

  void updateDatabase({
    required String status,
    required int id,
  }) {
    db.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataFromDB(db);
      emit(AppUpdateDBState());
    });
  }

  void deleteFromDB({
    required int id,
  }) {
    db.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then(
        (value) {
      getDataFromDB(db);
      emit(AppDeleteFromDBState());
    });
  }

  void changeBottomSheetState({
    required bool isShown,
    required IconData icon,
  }) {
    isBottomSheetShown = isShown;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }
}
