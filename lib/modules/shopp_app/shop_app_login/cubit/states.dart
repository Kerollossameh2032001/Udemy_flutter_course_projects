import 'package:todo_app/models/shop_app/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginIntialState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSucessState extends ShopLoginStates {
 final ShopLoginModel loginModel;

  ShopLoginSucessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginStates {
  final error;

  ShopLoginErrorState(this.error);
}

class ShopChangePasswordVisibilityState extends ShopLoginStates {}

