import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app/layout/news_layout/news_layout.dart';
import 'package:todo_app/layout/shop_app/cubit/cubit.dart';
import 'package:todo_app/layout/shop_app/shop_layout.dart';
import 'package:todo_app/modules/shopp_app/onboarding/onboarding_screen.dart';
import 'package:todo_app/modules/shopp_app/shop_app_login/shop_app_login_screen.dart';
import 'package:todo_app/shared/bloc_observer.dart';
import 'package:todo_app/shared/components/constant.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/shared/network/local/cachHelper.dart';
import 'package:todo_app/shared/network/remote/dio_helper.dart';
import 'package:todo_app/shared/style/themes.dart';
import 'layout/news_layout/cubit/cubit.dart';
import 'layout/todo_layout/layout.dart';
import 'modules/counter/counter_screen.dart';

Widget chooseStartedScreen(bool? isBoarding, String? token) {
  if (isBoarding != null) {
    if (token != null)
      return ShopLayout();
    else
      return ShopLoginScreen();
  } else {
    return OnBoardingScreen();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CachHelper.init();
  bool? isDark = CachHelper.getDate(key: 'isDark');

  Widget widget;
  bool? isBoarding = CachHelper.getDate(key: 'onBoarding');
  token = CachHelper.getDate(key: 'token');
  widget = chooseStartedScreen(isBoarding, token);

  print(token);
  BlocOverrides.runZoned(
    () {
      // Use cubits...
      runApp(MyApp(
        isDark: isDark,
        startedScreen: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget startedScreen;

  MyApp({required this.isDark, required this.startedScreen});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusinessData()
            ..getSportsData()
            ..getScienceData(),
        ),
        BlocProvider(
            create: (context) => AppCubit()..changeAppMode(fromShared: isDark)),
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavoritesData()..getUserData()
        )
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: (AppCubit.get(context).isDark)
                ? ThemeMode.dark
                : ThemeMode.light,
            home: startedScreen,
          );
        },
      ),
    );
  }
}
