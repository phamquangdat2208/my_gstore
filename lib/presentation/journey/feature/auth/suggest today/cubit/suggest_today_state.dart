import 'package:my_gstore/common/model/product_model.dart';

abstract class SuggestTodayState {
  final List<ProductModel>?  products;
  final bool isLastData;
  SuggestTodayState({this.products, this.isLastData = false});
}

class SuggestTodayInitState extends SuggestTodayState {}

class SuggestTodayGettingDataState extends SuggestTodayState {}

class SuggestTodayGotState extends SuggestTodayState {
  SuggestTodayGotState(List<ProductModel>? products, {bool isLastData = false})
      : super(
    products: products,
    isLastData: isLastData,
  );
}
class SuggestTodayGetFailState extends SuggestTodayState {}
class SuggestTodayLoadingMoreState extends SuggestTodayState {
  SuggestTodayLoadingMoreState(List<ProductModel>? products)
      : super(
    products: products,
  );
}

class SuggestTodayLoadMoreFailState extends SuggestTodayState {
  SuggestTodayLoadMoreFailState(List<ProductModel>? products)
      : super(
    products: products,
  );
}
