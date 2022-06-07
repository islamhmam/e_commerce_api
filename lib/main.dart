import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:e_commerce_api/layout/news_app/cubit/cubit.dart';
// import 'package:e_commerce_api/layout/news_app/news_layout.dart';
import 'package:e_commerce_api/layout/cubit/cubit.dart';
import 'package:e_commerce_api/layout/shop_layout.dart';
import 'package:e_commerce_api/modules/login/shop_login_screen.dart';
import 'package:e_commerce_api/modules/on_boarding/on_boarding_screen.dart';
import 'package:e_commerce_api/shared/bloc_observer.dart';
import 'package:e_commerce_api/shared/components/constants.dart';
import 'package:e_commerce_api/shared/cubit/cubit.dart';
import 'package:e_commerce_api/shared/cubit/states.dart';
import 'package:e_commerce_api/shared/network/local/cache_helper.dart';
import 'package:e_commerce_api/shared/network/remote/dio_helper.dart';
import 'package:e_commerce_api/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);

  if(onBoarding != null)
  {
    if(token != null) widget = ShopLayout();
    else widget = ShopLoginScreen();
  } else
  {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

// Stateless
// Stateful

// class MyApp

class MyApp extends StatelessWidget
{
  // constructor
  // build
  final bool? isDark;
  final Widget? startWidget;

  MyApp({
    this.isDark,
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
