import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/shop_app/cubit/states.dart';
import 'package:todo_app/models/shop_app/catrgoties_model.dart';
import 'package:todo_app/models/shop_app/change_favorites_model.dart';
import 'package:todo_app/models/shop_app/favorites_model.dart';
import 'package:todo_app/models/shop_app/home_model.dart';
import 'package:todo_app/modules/shopp_app/categories/categories_screen.dart';
import 'package:todo_app/modules/shopp_app/products/products_screen.dart';
import 'package:todo_app/shared/network/end_point/end_point.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';

import '../../../models/shop_app/login_model.dart';
import '../../../modules/shopp_app/favorit/favorits_screen.dart';
import '../../../modules/shopp_app/setting/settings_screen.dart';
import '../../../shared/components/constant.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopIntialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  List<Widget> bottomScreen = [
    const ProductScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];

  int currentIndex = 0;

  void changeBotton(index) {
    currentIndex = index;
    emit(ShopChangeBottonNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: HOME, token: token, lang: 'en').then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorite});
      });
      //print(favorites);
      emit(ShopSuccesHomeDataState());
    }).catchError((error) {
      print('Error ${error.toString()}');
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    emit(ShopLoadingCategoriesDataState());
    DioHelper.getData(url: GET_CATEGORIES, lang: 'en').then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccesCategoriesDataState());
    }).catchError((error) {
      print('Error ${error.toString()}');
      emit(ShopErrorCategoriesDataState());
    });
  }

  ChangeFavorites? changeFavorites;

  void changeFavoritesItem(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopLoadingChangeFavoritesDataState());

    DioHelper.postData(
      url: FAVORITES,
      token: token,
      data: {
        'product_id': productId,
      },
    ).then((value) {
      changeFavorites = ChangeFavorites.fromJson(value.data);
      if (!changeFavorites!.status) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavoritesData();
      }
      emit(ShopSuccesChangeFavoritesDataState(changeFavorites!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      print(error.toString());
      emit(ShopErrorChangeFavoritesDataState());
    });
  }

  FavoritesData? favoritesData;

  void getFavoritesData() {
    emit(ShopLoadingFavoritesDataState());
    DioHelper.getData(url: FAVORITES, token: token, lang: 'en').then((value) {
      favoritesData = FavoritesData.fromJson(value.data);
      //print(favoritesData!.data!.data![0].product!.name);
      emit(ShopSuccesFavoritesDataState());
    }).catchError((error) {
      print('Error ${error.toString()}');
      emit(ShopErrorFavoritesDataState());
    });
  }

  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(url: PROFILE, token: token).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      //print("1231231233213213213132132131332131321313");
      //print(userModel!.data!.name);
      emit(ShopSuccesUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void putUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(url: UPDATE_PROFILE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.message);
      emit(ShopSuccesUpdateUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserDataState());
    });
  }
}
