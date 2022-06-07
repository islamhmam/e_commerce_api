import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:e_commerce_api/modules/todo_app/archived_tasks/archived_tasks_screen.dart';
// import 'package:e_commerce_api/modules/todo_app/done_tasks/done_tasks_screen.dart';
// import 'package:e_commerce_api/modules/todo_app/new_tasks/new_tasks_screen.dart';
import 'package:e_commerce_api/shared/cubit/states.dart';
import 'package:e_commerce_api/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;




  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }







  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    @required bool? isShow,
    @required IconData? icon,
  }) {
    isBottomSheetShown = isShow!;
    fabIcon = icon!;

    emit(AppChangeBottomSheetState());
  }

  bool isDark = false;

  void changeAppMode({bool? fromShared})
  {
    if (fromShared != null)
    {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else
      {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
