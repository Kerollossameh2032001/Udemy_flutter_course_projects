import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/shared/network/local/cachHelper.dart';

import '../../modules/todo_app/archive_task_screen/archive_tasks.dart';
import '../../modules/todo_app/done_task_screen/done_tasks.dart';
import '../../modules/todo_app/task_screen/new_tasks.dart';



class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIntialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screen = [
    NewTasks(),
    DoneTasks(),
    ArchiveTasks(),
  ];

  List<String> titles = [
    "New Task",
    "Done Task",
    "Archive Task",
  ];

  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];

  IconData fabIcon = Icons.edit;
  bool isBottomSheetShow = false;

  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  //Method to Create the Database and tables
  void CreateDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        db
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT , status TEXT)')
            .then((value) => {print("table is created")})
            .catchError((Error) {
          print("Error when created table ${Error.toString()}");
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print("Data base is opened ");
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  //Method to insert in database
  Future InsertToDatabase(
      {required String title,
      required String time,
      required String date}) async {
    return await database
        .transaction(
      (txn) => txn.rawInsert(
          'INSERT INTO tasks(title,date,time,status) VALUES("$title" ,"$date","$time","new")'),
    )
        .then((value) {
      print("$value Row is inserted");
      emit(AppInsertDatabaseState());
      getDataFromDatabase(database);
    }).catchError((Error) => print("Error when inserted New Record"));
    return null;
  }

  //Method To get data from database
  void getDataFromDatabase(Database database) async {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];

    emit(AppGetDatabaseLoadingState());
    database.rawQuery("SELECT * FROM tasks").then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archiveTasks.add(element);
        }
      });
      print('The new tasks $newTasks');
      print('The done tasks $doneTasks');
      print('The archive tasks $archiveTasks');
      emit(AppGetDatabaseState());
    });
  }

  void changeBottomSheet({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShow = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  void updateDate({
    required String status,
    required int id,
  }) async {
    // Update some record
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({
    required int id,
  }) async {
    // Update some record
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  bool isDark = false;
  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CachHelper.putBoolean(key: 'isDark', value: isDark)
          .then((value) => emit(AppChangeModeState()));
    }
  }
}
