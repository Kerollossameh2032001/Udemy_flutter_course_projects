import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/news_layout/cubit/states.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';

import '../../../modules/news_app/business/business_screen.dart';
import '../../../modules/news_app/science/science_screen.dart';
import '../../../modules/news_app/sport/sport_screen.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItem = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: "Business"),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: "Sports"),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: "Science"),

  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    /*if (currentIndex == 1) getScienceData();
    if (currentIndex == 2) getScienceData();*/

    emit(NewsBottomNavState());
  }

//https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=43040f27d1ad420d994edda3a168ab10

  List business = [];

  void getBusinessData() {
    emit(NewsGetBusinessLoadyingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': 'add3ecc4f2a4420f8712101f4f605441',
    }).then((value) {
      business = value.data['articles'];
      print(business);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      emit(NewsGetBusinessErrorState(error));
    });
  }

  List science = [];

  void getScienceData() {
    emit(NewsGetScienceLoadyingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'science',
      'apiKey': 'add3ecc4f2a4420f8712101f4f605441',
    }).then((value) {
      science = value.data['articles'];
      print(science);
      emit(NewsGetScienceSuccessState());
    }).catchError((error) {
      emit(NewsGetScienceErrorState(error));
    });
  }

  List sports = [];

  void getSportsData() {
    emit(NewsGetSportsLoadyingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'Sports',
      'apiKey': 'add3ecc4f2a4420f8712101f4f605441',
    }).then((value) {
      sports = value.data['articles'];
      print(sports);
      emit(NewsGetSportsSuccessState());
    }).catchError((error) {
      emit(NewsGetSportsErrorState(error));
    });
  }

  List search = [];
  void getsearchData({required String value}) {
    emit(NewsGetSearchLoadyingState());
    DioHelper.getData(url: 'v2/everything', query: {
      'q': '$value',
      'apiKey': 'add3ecc4f2a4420f8712101f4f605441',
    }).then((value) {
      search = value.data['articles'];
      print(search);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      emit(NewsGetSearchErrorState(error));
    });
  }
}
