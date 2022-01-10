import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:my_gstore/common/global_app_cache/global_app_catch.dart';
import 'package:my_gstore/common/model/gshop_model.dart';
import 'package:my_gstore/common/model/product_model.dart';
import 'package:my_gstore/common/network/app_client.dart';
import 'package:my_gstore/common/ultils/common_util.dart';

import '../../../../../injector_container.dart';

class HomeCubit extends Cubit<HomeState> {
  final AppClient appClient;
  final SnackBarBloc snackBarBloc;
  final GlobalAppCache globalAppCache;
  HomeCubit(this.appClient, this.snackBarBloc, this.globalAppCache)
      : super(HomeInitState());
  void getInitData() async {
    try {
      emit(HomeGettingDataState());
      GlobalAppCache appCache = injector<GlobalAppCache>();
      // final position = globalAppCache.gspPosition;
      final getGShop = await getInforGShop(
          'Customer/GetShopGStoreNew?maxKm=25&page=1&pagesize=12&type=3');
      final getBestBuy = await getProduct(
          'productapp/GetBestBuyNew?page=1&pagesize=12');
      final getBestBuyNew = await getProduct(
          'ProductApp/GetBestProductForYouNew?km=25&latitude=21.023714&longitude=105.754272&page=1&pagesize=12');
      emit(HomeGotDataState(
        getGShop,
        getBestBuy,
        getBestBuyNew,
      ));
    } catch (e) {
      emit(HomeGotDataState([],[],[]));
      CommonUtils.handleException(snackBarBloc, e,
          methodName: 'getInitData HomeCubit');
    }
  }

  Future<List<GShopModels>> getInforGShop(String endPoint) async {
    List<GShopModels> result1 = [];
    final data = await appClient.get(endPoint);
    data['Data'].forEach((e) {
      result1.add(GShopModels.fromJson(e));
    });
    return result1;
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

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeGettingDataState extends HomeState {}

class HomeGotDataState extends HomeState {
  final List<GShopModels> getGShop;
  final List<ProductModel> getBestBuy;
  final List<ProductModel> getBestBuyNew;


  HomeGotDataState(this.getGShop,this.getBestBuyNew,this.getBestBuy);
}
