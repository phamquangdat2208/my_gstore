import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gstore/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:my_gstore/common/bloc/loading_bloc/loading_event.dart';
import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:my_gstore/common/global_app_cache/global_app_catch.dart';
import 'package:my_gstore/common/model/product_model.dart';
import 'package:my_gstore/common/network/app_client.dart';
import 'package:my_gstore/common/network/configs.dart';
import 'package:my_gstore/common/ultils/common_util.dart';

import '../../../../../injector_container.dart';
import 'all_product_state.dart';

class
AllProductCubit extends Cubit<AllProductState> {
  final AppClient appClient;
  final SnackBarBloc snackBarBloc;
  final GlobalAppCache globalAppCache;

  AllProductCubit(this.appClient, this.snackBarBloc, this.globalAppCache)
      : super(AllProductInitState());
  int _pageId = 1;
  int _pageSize = Configurations.pageSize;

  void getLoadData(String url) async {
    try {
      emit(AllProductGettingState());
      final getLoadData =
          await getProduct('${url}page=${_pageId}&pagesize=$_pageSize');
      emit(AllProductGotState(getLoadData));
    } catch (e) {
      CommonUtils.handleException(injector<SnackBarBloc>(), e,
          methodName: '_AllProductScreenState');
    } finally {
      injector<LoadingBloc>().add(FinishLoading());
    }
  }

  void getLoadMoreData(String url) async {
    try {
      emit(AllProductLoadingMoreState(state.products));
      final getLoadData =
          await getProduct('${url}page=${++_pageId}&pagesize=12');
      if (getLoadData.isNotEmpty) {
        state.products?.addAll(getLoadData);
      }
      emit(AllProductGotState(
        state.products,
        isLastData: getLoadData.length < Configurations.pageSize,
      ));
    } catch (e) {
      CommonUtils.handleException(injector<SnackBarBloc>(), e,
          methodName: '_AllProductScreenState');
    } finally {
      injector<LoadingBloc>().add(FinishLoading());
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
