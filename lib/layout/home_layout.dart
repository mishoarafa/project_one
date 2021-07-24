import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_one/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:project_one/modules/done_tasks/done_tasks_screen.dart';
import 'package:project_one/modules/new_tasks/new_tasks_screen.dart';
import 'package:project_one/shared/components/components.dart';
import 'package:project_one/shared/components/constants.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  late Database db;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController statusController = TextEditingController();

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

  @override
  void initState() {
    super.initState();

    createDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(titles[currentIndex]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!isBottomSheetShown) {
            scaffoldKey.currentState!
                .showBottomSheet(
                  (context) => Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          defaultFormField(
                            controller: titleController,
                            text: "Task Title",
                            prefixIcon: Icons.title,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Title must not be empty";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            controller: timeController,
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) {
                                timeController.text = value!.format(context);
                                print(value.format(context));
                              });
                            },
                            text: "Task Time",
                            textInputType: TextInputType.datetime,
                            prefixIcon: Icons.watch_later_outlined,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Time must not be empty";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            controller: dateController,
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.parse("2021-10-03"),
                              ).then((value) {
                                print(DateFormat.yMMMd().format(value!));
                                dateController.text =
                                    DateFormat.yMMMd().format(value);
                              });
                            },
                            text: "Task Date",
                            textInputType: TextInputType.datetime,
                            prefixIcon: Icons.calendar_today,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Date must not be empty";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  elevation: 50,
                )
                .closed
                .then((value) {
              isBottomSheetShown = !isBottomSheetShown;
              setState(() {
                fabIcon = Icons.edit;
              });
            });
            isBottomSheetShown = !isBottomSheetShown;
            setState(() {
              fabIcon = Icons.add;
            });
          } else {
            if (formKey.currentState!.validate()) {
              insertToDB(titleController.text, dateController.text,
                      timeController.text)
                  .then((value) {
                getDataFromDB(db).then((value) {
                  Get.back();
                  setState(() {
                    isBottomSheetShown = !isBottomSheetShown;
                    fabIcon = Icons.edit;

                    tasks = value;
                  });
                  print(tasks);
                });
              });
            }
          }
        },
        child: Icon(fabIcon),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
          print(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: "Tasks",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: "Done",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined),
            label: "Archived",
          ),
        ],
      ),
      body: (tasks.length > 0)? screens[currentIndex] : Center(child: CircularProgressIndicator()),
    );
  }

  void createDB() async {
    db = await openDatabase("todo.db", version: 1,
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
    }, onOpen: (database) {
      getDataFromDB(database).then((value) {
        setState(() {
          tasks = value;
        });
        print(tasks);
      });
      print("Database opened successfully !!");
    });
  }

  Future insertToDB(String title, String date, String time) async {
    return await db.transaction((txn) async {
      txn
          .rawInsert(
              "INSERT INTO tasks(title, date, time, status) VALUES('$title', '$date', '$time', 'new')")
          .then((value) {
        print("$value inserted successfully");
      }).catchError((error) {
        print("Error while inserting a record: ${error.toString()}");
      });
    });
  }

  Future getDataFromDB(database) async {
    return await database.rawQuery("SELECT * FROM tasks");
  }
}
