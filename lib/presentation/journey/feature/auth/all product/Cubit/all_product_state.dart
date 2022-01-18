import 'package:my_gstore/common/model/product_model.dart';

abstract class AllProductState {
  final List<ProductModel>?  products;
  final bool isLastData;
  AllProductState({this.products, this.isLastData = false});
}

class AllProductInitState extends AllProductState {}

class AllProductGettingState extends AllProductState {}

class AllProductGotState extends AllProductState {
  AllProductGotState(List<ProductModel>? products, {bool isLastData = false})
      : super(
    products: products,
    isLastData: isLastData,
  );
}
class AllProductGetFailState extends AllProductState {}
class AllProductLoadingMoreState extends AllProductState {
  AllProductLoadingMoreState(List<ProductModel>? products)
      : super(
    products: products,
  );
}

class AllProductLoadMoreFailState extends AllProductState {
  AllProductLoadMoreFailState(List<ProductModel>? products)
      : super(
    products: products,
  );
}
