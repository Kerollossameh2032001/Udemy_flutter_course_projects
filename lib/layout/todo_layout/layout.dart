import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class MyHomePage extends StatelessWidget {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..CreateDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if(state is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            body: ConditionalBuilder(
              builder: (context) => cubit.screen[cubit.currentIndex],
              condition: state is! AppGetDatabaseLoadingState/* true tasks.isNotEmpty*/,
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
            bottomNavigationBar: BottomNavigationBar(
              elevation: 20,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                AppCubit.get(context).changeCurrentIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: "New Tasks",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline),
                  label: "Done Tasks",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: "Archive",
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShow) {
                  if (_formKey.currentState!.validate()) {
                    cubit.InsertToDatabase(
                      title: _titleController.text,
                      time: _timeController.text,
                      date: _dateController.text,
                    );
                    /*InsertToDatabase(
                      title: _titleController.text,
                      time: _timeController.text,
                      date: _dateController.text,
                    ).then((value) {

                      _isBottomSheetShow = false;
                      _dateController.text = "";
                      _titleController.text = "";
                      _timeController.text = "";
                      */ /* setState(() => _fabIcon = Icons.edit);*/ /*
                    });*/
                  }
                } else {
                  _scaffoldKey.currentState!
                      .showBottomSheet((context) => Container(
                            padding: EdgeInsets.all(20.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    controller: _titleController,
                                    onSaved: (value) =>
                                        _titleController.text = value!,
                                    decoration: const InputDecoration(
                                      labelText: 'Enter The Task Title',
                                      border: OutlineInputBorder(),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 5)),
                                      prefixIcon: Icon(Icons.title),
                                    ),
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'title must not be empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: _timeController,
                                    decoration: const InputDecoration(
                                      labelText: 'Enter the Task Time',
                                      border: OutlineInputBorder(),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 5)),
                                      prefixIcon:
                                          Icon(Icons.watch_later_outlined),
                                    ),
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'time must not be empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onTap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then((value) => _timeController.text =
                                          value!.format(context).toString());
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    
                                    controller: _dateController,
                                    decoration: const InputDecoration(
                                      labelText: 'Enter The Date',
                                      border: OutlineInputBorder(),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 5)),
                                      prefixIcon:
                                          Icon(Icons.calendar_today_outlined),
                                    ),
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'title must not be empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse("2022-09-16"),
                                      ).then((value) => _dateController.text =
                                          DateFormat.yMMMd().format(value!));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .closed
                      .then((value) {
                    cubit.changeBottomSheet(isShow: false, icon: Icons.edit);
                  });
                  cubit.changeBottomSheet(isShow: true, icon: Icons.add);
                }
              },
              child: Icon(cubit.fabIcon),
            ),
          );
        },
      ),
    );
  }
}
