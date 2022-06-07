import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_api/models/search_model.dart';
import 'package:e_commerce_api/modules/search/cubit/states.dart';
import 'package:e_commerce_api/shared/components/constants.dart';
import 'package:e_commerce_api/shared/network/end_points.dart';
import 'package:e_commerce_api/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value)
    {
      model = SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
