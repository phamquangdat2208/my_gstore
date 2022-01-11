import 'package:flutter/material.dart';
import 'package:my_gstore/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:my_gstore/common/bloc/loading_bloc/loading_event.dart';
import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:my_gstore/common/customs/custom_gesturedetactor.dart';
import 'package:my_gstore/common/model/product_model.dart';
import 'package:my_gstore/common/network/app_client.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/ultils/common_util.dart';
import 'package:my_gstore/common/ultils/screen_utils.dart';
import 'package:my_gstore/presentation/journey/feature/screens/Home/component/filter_screen_bottom_sheet.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/Product%20Item/gridview_product_item.dart';

import '../../../../injector_container.dart';
import '../../../../routes.dart';

class ArgumentAllProductScreen {
  final String? url;
  final String? title;

  ArgumentAllProductScreen({this.url, this.title});
}

class AllProductScreen extends StatefulWidget {
  ArgumentAllProductScreen? argument;

  AllProductScreen({Key? key, required this.argument}) : super(key: key);

  @override
  _AllProductScreenState createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  List<ProductModel> _allProductModel = [];

  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    try {
      injector<LoadingBloc>().add(StartLoading());
      final data = await injector<AppClient>().get(widget.argument?.url ?? '');
      data['Data'].forEach((e) {
        _allProductModel.add(ProductModel.fromJson(e));
      });
      setState(() {});
    } catch (e) {
      CommonUtils.handleException(injector<SnackBarBloc>(), e,
          methodName: '_AllProductScreenState');
    } finally {
      injector<LoadingBloc>().add(FinishLoading());
    }
  }

  @override
  Widget build(BuildContext context) {
    final _itemWidth = (GScreenUtil.screenWidthDp - 48) / 2;
    final _itemHeight = _itemWidth + 80;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          widget.argument?.title ?? '',
          style: TextStyle(
              fontSize: 16,
              color: AppColors.grey9,
              fontWeight: FontWeight.w500),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomGestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.search,
                  color: Colors.black,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomGestureDetector(
                onTap: () {
                  onFilterPress();
                },
                child: const Icon(
                  Icons.tune,
                  color: Colors.black,
                )),
          ),
        ],
        leading: CustomGestureDetector(
          onTap: () {
            Routes.instance.pop();
          },
          child: const Icon(
            Icons.keyboard_arrow_left,
            color: Colors.black,
          ),
        ),
      ),
      body: GridView.builder(
        itemCount: _allProductModel.length,
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 12.0,
          childAspectRatio: _itemWidth / _itemHeight,
        ),
        itemBuilder: (context, index) {
          return CategoryDetailWidgetItemProduct(
            itemWidth: _itemWidth,
            productModel: _allProductModel[index],
          );
        },
      ),
    );
  }

  void onFilterPress() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: AppColors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
              heightFactor: 0.85, child: FilterScreenSelect());
        });
  }
}
