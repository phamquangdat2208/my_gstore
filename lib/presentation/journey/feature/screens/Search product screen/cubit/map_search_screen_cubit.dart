import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/common/constants/search_product_constants.dart';
import 'package:my_gstore/common/constants/service_package_constant.dart';
import 'package:my_gstore/common/global_app_cache/global_app_catch.dart';
import 'package:my_gstore/common/model/detail_product_model.dart';
import 'package:my_gstore/common/model/marker_model.dart';
import 'package:my_gstore/common/model/product_model.dart';
import 'package:my_gstore/common/network/app_client.dart';
import 'package:my_gstore/common/network/configs.dart';
import 'package:my_gstore/common/ultils/common_util.dart';
import 'package:my_gstore/common/ultils/log_util.dart';
import 'dart:ui' as ui;
import '../../../../../injector_container.dart';
import 'package:http/http.dart' as http;

class MapSearchScreenCubit extends Cubit<MapSearchScreenState> {
  final AppClient appClient;
  final SnackBarBloc snackBarBloc;
  final GlobalAppCache globalAppCache;

  MapSearchScreenCubit(this.appClient, this.snackBarBloc, this.globalAppCache)
      : super(MapSearchScreenInitState());
  int _pageId=1;
  void getDataLoadInMap() async {
    try {
      emit(MapSearchScreenGettingDataState());
      final getSampleProduct =
          await getProduct('productapp/GetBestBuyNew?page=${_pageId}&pagesize=12');
      emit(MapSearchScreenGotDataState(
        getSampleProduct,
      ));
    } catch (e) {
      emit(MapSearchScreenGotDataState([],));
      CommonUtils.handleException(snackBarBloc, e,
          methodName: 'getInitData MapSearchScreenCubit');
    }
  }
  void getMoreLoadData() async {

    try {
      emit(MapSearchScreenLoadingMoreState(state.products));
      ++_pageId;
      final getLoadMoreData = await getProduct(
          'productapp/GetBestBuyNew?page=$_pageId&pagesize=12');
      if (getLoadMoreData.isNotEmpty){
        state.products?.addAll(getLoadMoreData);
      }
      emit(MapSearchScreenGotDataState(
        state.products,
        isLastData: getLoadMoreData.length < Configurations.pageSize,
      ));
    } catch (e) {
      emit(MapSearchScreenGetFailState());
      CommonUtils.handleException(
        snackBarBloc,
        e,
        methodName: 'getMoreSearchScreen',
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

  Future<List<MarkerModel>> getDataMarkerInMap({
    double? maxKm,
    String? name = '',
    int? minPrice,
    int? maxPrice,
    double? lat,
    double? lng,
    int? categoryId,
    bool? isGstore,
  }) async {
    final result = <MarkerModel>[];
    final data = await appClient
        .get('productapp/GetCategoryForMapNew?name=${name ?? ''}&minKm=0&maxKm='
        '${maxKm ?? Configurations.maxKmInt}&minPrice='
        '${minPrice ?? 0}&maxPrice=${maxPrice ?? 0}'
        '&categoryId=${categoryId ?? 0}&latitude=$lat&longitude'
        '=$lng&isGstore=${isGstore ?? false}');
    if (data.containsKey('Data')) {
      data['Data']?.forEach((obj) {
        result.add(MarkerModel.fromJson(obj));
      });
    }
    return await createMarker(result);
  }
  Future<List<MarkerModel>> createMarker(List<MarkerModel> input,
      {bool forHome = false}) async {
    final listBitmapDescription = await _getByteIconFromUrl(input);
    if (listBitmapDescription.isNotEmpty) {
      // lúc xử lý multi async task thì data bị xáo trộn dẫn đến phải dùng tọa độ để gán lại
      for (var i = 0; i < listBitmapDescription.length; i++) {
        for (final obj in listBitmapDescription) {
          if (obj.lat == input[i].latitude) {
            input[i].dataIconMarker = obj.bitmapDescriptor;
            if (forHome == true) {
              input[i].uint8list = obj.uint8list;
            }
            break;
          }
        }
      }
    }
    return input;
  }

  Future<List<ArgumentDataMarker>> _getByteIconFromUrl(
      List<MarkerModel> listLocations) async {
    // lọc nhưng data có cùng vị trí
    List<MarkerModel> filterData = <MarkerModel>[];
    for (final obj in listLocations) {
      MarkerModel? temp;
      for (final containShopModel in filterData) {
        if (containShopModel.latitude == obj.latitude &&
            containShopModel.longitude == obj.longitude) {
          temp = containShopModel;
          break;
        }
      }
      if (temp == null || filterData.isEmpty) {
        filterData.add(obj);
      }
    }

    List<ArgumentDataMarker> valueList = [];
    await Future.wait(filterData.map((key) async {
      ArgumentDataMarker? bitmapDescription = await _getBitmapDescription(
          key.latitude ?? 0,
          key.longitude ?? 0,
          key.urlIcon ?? '',
          key.sort ?? 0);
      if (bitmapDescription != null) {
        valueList.add(bitmapDescription);
      }
    }));
    return valueList;
  }

  // convert url image to BitmapDescriptor of icon marker
  Future<ArgumentDataMarker?> _getBitmapDescription(
      double lat, double lng, String url, int sort) async {
    try {
      if (sort >= ServicePackageConstant.gShopTS) {
        Uint8List? markerIcon = await CommonUtils.getBytesFromAsset(
            IconConst.markerGstore, SearchProductConst.sizeMarkerMedium);
        if (markerIcon == null) {
          return null;
        }
        return ArgumentDataMarker(
            lat, lng, BitmapDescriptor.fromBytes(markerIcon), markerIcon);
      }

      if (CommonUtils.isEmptyOrNull(url)) {
        Uint8List? markerIcon = await CommonUtils.getBytesFromAsset(
            IconConst.markerCart, SearchProductConst.sizeMarkerNormal);
        if (markerIcon == null) {
          return null;
        }
        return ArgumentDataMarker(
            lat, lng, BitmapDescriptor.fromBytes(markerIcon), markerIcon);
      }
      var request = await http.get(Uri.parse(url));
      Uint8List? bytes = request.bodyBytes;
      int sizeMarker = sort == ServicePackageConstant.reputationTS
          ? SearchProductConst.sizeMarkerMedium
          : SearchProductConst.sizeMarkerNormal;
      var codec = await ui.instantiateImageCodec(
        bytes,
        targetHeight: sizeMarker,
        targetWidth: sizeMarker - 20,
      );
      var frameInfo = await codec.getNextFrame();
      ui.Image targetUiImage = frameInfo.image;
      ByteData? targetByteData =
      await targetUiImage.toByteData(format: ui.ImageByteFormat.png);
      bytes = targetByteData?.buffer.asUint8List();
      if (bytes == null) {
        return null;
      }
      return ArgumentDataMarker(
          lat, lng, BitmapDescriptor.fromBytes(bytes), bytes);
    } catch (e) {
      LOG.e('_getBitmapDescription: ${e.toString()}');
      Uint8List? markerIcon = await CommonUtils.getBytesFromAsset(
          IconConst.markerCart, SearchProductConst.sizeMarkerNormal);
      if (markerIcon == null) {
        return null;
      }
      return ArgumentDataMarker(
          lat, lng, BitmapDescriptor.fromBytes(markerIcon), markerIcon);
    }
  }
}
class ArgumentDataMarker {
  //ko có id nên dùng lat để identifier tránh việc chạy multi async bị lẫn marker
  double lat;
  double lng;
  final BitmapDescriptor bitmapDescriptor;
  Uint8List uint8list;

  ArgumentDataMarker(this.lat, this.lng, this.bitmapDescriptor, this.uint8list);
}
abstract class MapSearchScreenState {
  final List<ProductModel>? products;
  final bool isLastData;
  MapSearchScreenState({this.products,this.isLastData =false});
}

class MapSearchScreenInitState extends MapSearchScreenState {}

class MapSearchScreenGettingDataState extends MapSearchScreenState {}

class MapSearchScreenGotDataState extends MapSearchScreenState {
  MapSearchScreenGotDataState(List<ProductModel>? products, {bool isLastData = false})
      : super(
    products: products,
    isLastData: isLastData,
  );
}
class MapSearchScreenGetFailState extends MapSearchScreenState {}
class MapSearchScreenLoadingMoreState extends MapSearchScreenState {
  MapSearchScreenLoadingMoreState(List<ProductModel>? products)
      : super(
    products: products,
  );
}

class MapSearchScreenLoadMoreFailState extends MapSearchScreenState {
  MapSearchScreenLoadMoreFailState(List<ProductModel>? products)
      : super(
    products: products,
  );
}
