import 'package:todo_app/models/shop_app/login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterIntialState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSucessState extends ShopRegisterStates {
  final ShopLoginModel loginModel;

  ShopRegisterSucessState(this.loginModel);
}

class ShopRegisterErrorState extends ShopRegisterStates {
  final error;

  ShopRegisterErrorState(this.error);
}

class ShopRegisterChangePasswordVisibilityState extends ShopRegisterStates {}

