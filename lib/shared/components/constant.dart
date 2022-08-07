import 'package:flutter/material.dart';
import 'package:todo_app/modules/shopp_app/shop_app_login/shop_app_login_screen.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/network/local/cachHelper.dart';

String? token = '';

void sinOut(BuildContext context){
  CachHelper.removeData(key: 'token').then((value){
    if(value){
      navigateAndFinish(context, ShopLoginScreen());
    }
  });

}