import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/shop_app/login_model.dart';
import 'package:todo_app/modules/shopp_app/shop_app_login/cubit/states.dart';
import 'package:todo_app/shared/network/end_point/end_point.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginIntialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  var suffix = Icon(Icons.visibility);

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword
        ? Icon(Icons.visibility)
        : Icon(Icons.visibility_off_outlined);

    emit(ShopChangePasswordVisibilityState());
  }

  late ShopLoginModel loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      //print(loginModel.data!.token);
      print(loginModel.message);
      emit(ShopLoginSucessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error));
    });
  }
}
