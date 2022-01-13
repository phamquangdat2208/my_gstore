import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:my_gstore/common/global_app_cache/global_app_catch.dart';
import 'package:my_gstore/common/model/detail_product_model.dart';
import 'package:my_gstore/common/model/product_model.dart';
import 'package:my_gstore/common/network/app_client.dart';
import 'package:my_gstore/common/ultils/common_util.dart';

import '../../../../../injector_container.dart';

class DetailProductCubit extends Cubit<DetailState>{
  final AppClient appClient;
  final SnackBarBloc snackBarBloc;
  final GlobalAppCache globalAppCache;
  DetailProductCubit(this.appClient, this.snackBarBloc, this.globalAppCache)
      : super(DetailInitState());


  void getDataProduct(String id) async {
    emit(DetailGettingDataState());
    List<String> listUrlImage = [];
    try {
      var data= await appClient.post('ProductApp/GetById?id=${id}&latitude=${injector<AppClient>().header?.lat}&longitude=${injector<AppClient>().header?.lng}');
      var productModel = ProductModels.fromJson(data);
      var dataProduct = productModel.data;
      final getSampleShop = await getProduct(
          'productapp/GetProductSampleShop?id=${id}&page=1&pagesize=12&latitude=${injector<AppClient>().header?.lat}&longitude=${injector<AppClient>().header?.lng}');

      if(productModel.erros == false) {
        if(dataProduct?.lstPictures!= null){
          for(int i =0; i< dataProduct!.lstPictures!.length; i++){
            listUrlImage.add(dataProduct.lstPictures![i].url!);
          }
        }
        emit(DetailGotDataState(
          dataProduct!,
          getSampleShop,
          listUrlImage
        ));
        Future.delayed(const Duration(seconds: 2));
      }

    } on Exception catch (e) {
      CommonUtils.handleException(snackBarBloc, e,
          methodName: 'getInitData DetailCubit');
    }

    // }
    // try {
    //
    // } catch (e) {
    //   emit(DetailGotDataState(,));
    //   CommonUtils.handleException(snackBarBloc, e,
    //       methodName: 'getInitData HomeCubit');
    // }


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
abstract class DetailState {}

class DetailInitState extends DetailState {}

class DetailGettingDataState extends DetailState {}

class DetailGotDataState extends DetailState {
  final DataProduct getDetail;
  final List<ProductModel> getSampleShop;
  final List<String> listUrlImage;
  DetailGotDataState(this.getDetail,this.getSampleShop, this.listUrlImage);
}