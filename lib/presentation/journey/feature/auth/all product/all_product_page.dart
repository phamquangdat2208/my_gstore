import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gstore/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:my_gstore/common/bloc/loading_bloc/loading_event.dart';
import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:my_gstore/common/customs/custom_circular_indicator.dart';
import 'package:my_gstore/common/customs/custom_gesturedetactor.dart';
import 'package:my_gstore/common/model/product_model.dart';
import 'package:my_gstore/common/network/app_client.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/ultils/common_util.dart';
import 'package:my_gstore/common/ultils/screen_utils.dart';
import 'package:my_gstore/presentation/journey/feature/auth/all%20product/Cubit/all_product_cubit.dart';
import 'package:my_gstore/presentation/journey/feature/auth/all%20product/Cubit/all_product_state.dart';
import 'package:my_gstore/presentation/journey/feature/screens/Home/component/filter_screen_bottom_sheet.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/Product%20Item/gridview_product_item.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/gridview_product.dart';

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
  AllProductCubit _allProductCubit = injector<AllProductCubit>();
   ScrollController controller = ScrollController();
  bool _enableContinueLoadMore = true;
  bool _runFirst = true;

  void initState() {
    _allProductCubit.getLoadData(widget.argument?.url ?? '');
    controller.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (controller.position.extentAfter < 100) {
      if (_enableContinueLoadMore) {
        _enableContinueLoadMore = false;
        _allProductCubit.getLoadMoreData(widget.argument?.url ?? '');
      }
    }
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
        body: SingleChildScrollView(
          controller: controller,
          child: Column(
            children: [
              BlocBuilder<AllProductCubit, AllProductState>(
                bloc: _allProductCubit,
                buildWhen: (_, state) {
                  return state is AllProductGettingState ||
                      state is AllProductGotState;
                },
                builder: (_, state) {
                  if (state is AllProductGettingState) {
                    return CustomCircularIndicator();
                  }
                  if (state is AllProductGotState &&
                      (state.products?.isNotEmpty ?? false)) {
                    if (!state.isLastData) {
                      _enableContinueLoadMore = true;
                    }
                    return GridViewDisplayProduct(
                      label: '',
                      courses: state.products,
                    );
                  }
                  return Center(child: Text('loi'));
                },
              ),
              BlocBuilder<AllProductCubit, AllProductState>(
                  bloc: _allProductCubit,
                  builder: (_, state) {
                    if (state is AllProductLoadingMoreState) {
                      return CircularProgressIndicator(color: AppColors.grey7,);
                    }
                    return SizedBox();
                  })
            ],
          ),
        ));
  }
}
