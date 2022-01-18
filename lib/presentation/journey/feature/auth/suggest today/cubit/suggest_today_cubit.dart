
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:my_gstore/common/global_app_cache/global_app_catch.dart';
import 'package:my_gstore/common/model/product_model.dart';
import 'package:my_gstore/common/network/app_client.dart';
import 'package:my_gstore/common/network/configs.dart';
import 'package:my_gstore/common/ultils/common_util.dart';
import 'package:my_gstore/presentation/journey/feature/auth/suggest%20today/cubit/suggest_today_state.dart';

import '../../../../../injector_container.dart';

class SuggestTodayCubit extends Cubit<SuggestTodayState> {
  final AppClient appClient;
  final SnackBarBloc snackBarBloc;
  final GlobalAppCache globalAppCache;
  SuggestTodayCubit(this.appClient, this.snackBarBloc, this.globalAppCache)
      : super(SuggestTodayInitState());
  int _pageId = 1;
  void getDataSuggestToday() async {
    try {
      emit(SuggestTodayGettingDataState());
      final getBestBuyNew = await getProduct(
          'ProductApp/GetBestProductForYouNew?km=25&latitude=21.023714&longitude=105.754272&page=${_pageId}&pagesize=12');
      emit(SuggestTodayGotState(
        getBestBuyNew,
      ));
    } catch (e) {
      emit(SuggestTodayGotState([]));
      CommonUtils.handleException(snackBarBloc, e,
          methodName: 'getInitData SuggestTodayCubit');
    }
  }
  void getMoreSuggestToday() async {
    try {
      emit(SuggestTodayLoadingMoreState(state.products));
      ++_pageId;
      final getLoadMoreData = await getProduct(
          'ProductApp/GetBestProductForYouNew?km=25&latitude=21.023714&longitude=105.754272&page=${_pageId}&pagesize=12');
      if (getLoadMoreData.isNotEmpty){
        state.products?.addAll(getLoadMoreData);
      }
      emit(SuggestTodayGotState(
        state.products,
        isLastData: getLoadMoreData.length < Configurations.pageSize,
      ));
    } catch (e) {
      emit(SuggestTodayGetFailState());
      CommonUtils.handleException(
        snackBarBloc,
        e,
        methodName: 'getMoreSuggestToday',
      );
    }
  }
  Future<List<ProductModel>> getProduct(String endPoint) async {
    List<ProductModel> result = [];
    final data = await appClient.get(endPoint);
    data['Data'].forEach((e) {
      result.add(ProductModel.fromJson(e));
    });
    return result;
  }
}


