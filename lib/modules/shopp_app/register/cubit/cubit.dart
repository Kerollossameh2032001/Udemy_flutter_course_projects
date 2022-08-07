import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/shop_app/login_model.dart';
import 'package:todo_app/modules/shopp_app/register/cubit/states.dart';
import 'package:todo_app/shared/network/end_point/end_point.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterIntialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  var suffix = Icon(Icons.visibility);

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword
        ? Icon(Icons.visibility)
        : Icon(Icons.visibility_off_outlined);

    emit(ShopRegisterChangePasswordVisibilityState());
  }

  late ShopLoginModel? loginModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSucessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error));
    });
  }
}
