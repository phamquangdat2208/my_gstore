import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:my_gstore/common/global_app_cache/global_app_catch.dart';
import 'package:my_gstore/common/model/gshop_model.dart';
import 'package:my_gstore/common/model/product_model.dart';
import 'package:my_gstore/common/model/user_model.dart';
import 'package:my_gstore/common/network/app_client.dart';
import 'package:my_gstore/common/network/configs.dart';
import 'package:my_gstore/common/ultils/common_util.dart';

import '../../../../../injector_container.dart';

class GShopPageCubit extends Cubit<GShopState> {
  final AppClient appClient;
  final SnackBarBloc snackBarBloc;
  final GlobalAppCache globalAppCache;

  GShopPageCubit(this.appClient, this.snackBarBloc, this.globalAppCache)
      : super(GShopInitState());

  void getDataShop(int? id) async {
    try {
      emit(GShopGettingDataState());
      GlobalAppCache appCache = injector<GlobalAppCache>();
      final getInfo = await getInforGShop('Customer/ShopPresigeDetail?id=$id');
      final getGMall = await getProduct(
          'productapp/GetProductForMapElastic?name=&minKm=0&maxKm=25&cateId=0&minPrice=0&maxPrice=1000000&latitude=${injector<AppClient>().header?.lat}&longitude=${injector<AppClient>().header?.lng}&page=1&pagesize=12&isGstore=SM');
      final getProductKG = await getProduct(
          'ProductApp/GetBestProductForYouNew?km=25&latitude=${injector<AppClient>().header?.lat}&longitude=${injector<AppClient>().header?.lng}&page=4&pagesize=12');
      final getProductTB = await getProduct(
          'ProductApp/GetAllProductByShopId?shopid=$id&page=1&pagesize='
              '${Configurations.pageSize}');
      final getSampleGShop = await getGShop('Customer/GetShopGStoreNew?maxKm=25&page=1&pagesize=12&type=3');
      emit(GShopGotDataState(
          getInfo, getGMall, getProductKG, getProductTB, getSampleGShop));
    } catch (e) {
      CommonUtils.handleException(snackBarBloc, e,
          methodName: 'getInitData GShopPageCubit');
    }
  }
 
  Future<UserModel> getInforGShop(String endPoint) async {
    final data = await appClient.get(endPoint);
    return UserModel.fromJson(data['Data']);
  }
  Future <List<GShopModels>> getGShop(String endPoint) async{
    List<GShopModels> result=[];
    final data = await appClient.get(endPoint);
    data['Data'].forEach((e){
      result.add(GShopModels.fromJson(e));
    });
    return result;
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

abstract class GShopState {}

class GShopInitState extends GShopState {}

class GShopGettingDataState extends GShopState {}

class GShopGotDataState extends GShopState {
  final UserModel getGShop;
  final List<ProductModel> getGMall;
  final List<ProductModel> getProductKG;
  final List<ProductModel> getProductTB;
  final List<GShopModels> getSampleGShop;

  GShopGotDataState(this.getGShop, this.getGMall, this.getProductKG,
      this.getProductTB, this.getSampleGShop);
}
