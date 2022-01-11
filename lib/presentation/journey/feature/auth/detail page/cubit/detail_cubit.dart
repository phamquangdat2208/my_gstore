// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_bloc.dart';
// import 'package:my_gstore/common/global_app_cache/global_app_catch.dart';
// import 'package:my_gstore/common/model/detail_product_model.dart';
// import 'package:my_gstore/common/network/app_client.dart';
// import 'package:my_gstore/common/ultils/common_util.dart';
//
// import '../../../../../injector_container.dart';
//
// class DetailProductCubit extends Cubit<DetailState>{
//   final AppClient appClient;
//   final SnackBarBloc snackBarBloc;
//   final GlobalAppCache globalAppCache;
//   DetailProductCubit(this.appClient, this.snackBarBloc, this.globalAppCache)
//       : super(HomeInitState());
//   void getInitData() async {
//     try {
//       emit(DetailGettingDataState());
//       final getDetail= await getDetailProduct('ProductApp/GetById?id=2882&latitude=21.030235&longitude=105.761697');
//       emit(DetailGotDataState(
//         getDetail,
//       ));
//     } catch (e) {
//       emit(DetailGotDataState([]));
//       CommonUtils.handleException(snackBarBloc, e,
//           methodName: 'getInitData HomeCubit');
//     }
//   }
//   Future <List<DetailProductModel>> getDetailProduct(String endPoint) async{
//     List<DetailProductModel> result=[];
//     final data = await appClient.get(endPoint);
//     data['Data'].forEach((e) {
//       result.add(DetailProductModel.fromJson(e));
//     });
//     return result;
//
//
//   }
// }
// abstract class DetailState {}
//
// class HomeInitState extends DetailState {}
//
// class DetailGettingDataState extends DetailState {}
//
// class DetailGotDataState extends DetailState {
//   final List<DetailProductModel> getDetail;
//   DetailGotDataState(this.getDetail);
// }