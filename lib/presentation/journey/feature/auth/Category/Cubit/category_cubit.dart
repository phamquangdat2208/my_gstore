import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:my_gstore/common/global_app_cache/global_app_catch.dart';
import 'package:my_gstore/common/model/banner_model.dart';
import 'package:my_gstore/common/model/category_model.dart';
import 'package:my_gstore/common/model/gshop_model.dart';
import 'package:my_gstore/common/model/product_model.dart';
import 'package:my_gstore/common/network/app_client.dart';
import 'package:my_gstore/common/ultils/common_util.dart';
import '../../../../../injector_container.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final AppClient appClient;
  final SnackBarBloc snackBarBloc;
  final GlobalAppCache globalAppCache;
  CategoryCubit(this.appClient, this.snackBarBloc, this.globalAppCache)
      : super(CategoryInitState());
  void getInitData() async {
    try {
      emit(CategoryGettingDataState());
      // GlobalAppCache appCache = injector<GlobalAppCache>();
      // final position = globalAppCache.gspPosition;
      final getbanner  = await getBanner('Advertising/GetByPosition?id=8');
      final getCategories = await getCategory('Category/GetAllProducts');
      emit(CategoryGotDataState(
        getbanner,
        getCategories,
      ));
    } catch (e) {
      emit(CategoryGotDataState([],[]));
      CommonUtils.handleException(snackBarBloc, e,
          methodName: 'getInitData CategoryCubit');
    }
  }
  Future<List<ItemCategory>> getCategory(String endPoint) async{
    List<ItemCategory> result=[];
    final data = await appClient.get(endPoint);
    data['Data'].forEach((e) {
      var a =CategoryModel.fromJson(e);
      result.add(ItemCategory(a.name!, a.urlIcon??""));
    });
    return result;
  }
  Future<List<BannerModels>> getBanner(String endPoint) async{
    List<BannerModels> result=[];
    final data = await appClient.get(endPoint);
    data['Data'].forEach((e) {
      result.add(BannerModels.fromJson(e));
    });
    return result;
  }
}
abstract class CategoryState {}
class CategoryInitState extends CategoryState {}

class CategoryGettingDataState extends CategoryState {}

class CategoryGotDataState extends CategoryState {
  final List<BannerModels> getBanner;
  final List<ItemCategory> getCategories;
  CategoryGotDataState(this.getBanner,this.getCategories);
}
class ItemCategory {
  ItemCategory(this.nameItem, this.link);
  final String nameItem;
  final String link;
}

