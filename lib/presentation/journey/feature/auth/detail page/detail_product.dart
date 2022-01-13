import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gstore/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:my_gstore/common/bloc/loading_bloc/loading_event.dart';
import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:my_gstore/common/constants/home_constant.dart';
import 'package:my_gstore/common/constants/image_constant.dart';
import 'package:my_gstore/common/constants/string_const.dart';
import 'package:my_gstore/common/customs/custom_gesturedetactor.dart';
import 'package:my_gstore/common/model/detail_product_model.dart';
import 'package:my_gstore/common/navigation/route_names.dart';
import 'package:my_gstore/common/network/app_client.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/common/ultils/common_util.dart';
import 'package:my_gstore/common/ultils/format_utils.dart';
import 'package:my_gstore/presentation/journey/feature/auth/all%20product/all_product_page.dart';
import 'package:my_gstore/presentation/journey/feature/auth/detail%20page/widget/demo_pageview_title.dart';
import 'package:my_gstore/presentation/journey/feature/auth/detail%20page/widget/page_container_demo.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/Product%20Item/listview_product.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/custom_cache_image_network.dart';

import '../../../../injector_container.dart';
import '../../../../routes.dart';
import 'cubit/detail_cubit.dart';

class ProductDetailPage extends StatefulWidget {
  int? id;

  ProductDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  DetailProductCubit _detailCubit = injector<DetailProductCubit>();
  int _currentindex = 0;
  int _index = 0;

  @override
  void initState() {
    // _initData();
    _detailCubit.getDataProduct(widget.id.toString());
    super.initState();
  }

  // void _initData() async {
  //   try {
  //     injector<LoadingBloc>().add(StartLoading());
  //     final data = await injector<AppClient>().get(
  //         'ProductApp/GetById?id=${widget.id}&latitude=21.030235&longitude=105.761697');
  //     _detailProductModel = DetailProductModel.fromJson(data['Data']);
  //     setState(() {});
  //   } catch (e) {
  //     CommonUtils.handleException(injector<SnackBarBloc>(), e,
  //         methodName: 'getThemes DetailProduct');
  //     Routes.instance.pop();
  //   } finally {
  //     injector<LoadingBloc>().add(FinishLoading());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(250.0),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CustomGestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.5),
                          ),
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 18,
                          ),
                        ))),
                Spacer(),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        padding: EdgeInsets.all(5),
                        width: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        child: const Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                          size: 18,
                        ))),
                const SizedBox(
                  width: 10.0,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        padding: EdgeInsets.all(5),
                        width: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 18,
                        ))),
                SizedBox(
                  width: 10.0,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        padding: EdgeInsets.all(5),
                        width: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        child: Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                          size: 18,
                        ))),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            BlocBuilder<DetailProductCubit, DetailState>(
              bloc: _detailCubit,
              builder: (_, state) {
                if (state is DetailGettingDataState) {
                  return SizedBox();
                }
                if (state is DetailGotDataState) {
                  return Column(children: [
                  state.getDetail.lstPictures == null
                  ? Container(
                      height: MediaQuery.of(context).size.height * 1 / 2,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: CustomCacheImageNetwork(
                url: state.getDetail.urlPicture ?? '',
                fit: BoxFit.cover,
                ),
                )
                    : Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: CarouselSlider(
                options: CarouselOptions(
                height: MediaQuery.of(context).size.height *
                1 /
                2-20,
                onPageChanged: (index, other) {
                setState(() {
                _currentindex = index + 1;
                });
                },
                viewportFraction: 1,
                autoPlay: true),
                items: state.listUrlImage
                    .map((e) => CustomCacheImageNetwork(
                url: e,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height *
                1 /
                2-20,
                width:
                MediaQuery.of(context).size.width,
                ))
                    .toList(),
                ),
                ),
                Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                // height: 220,
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Row(
                children: [
                Icon(
                Icons.shield,
                color: AppColors.green,
                ),
                Text(StringConst.isGShop,
                style: TextStyle(color: AppColors.green)),
                ],
                ),
                SizedBox(height: 8),
                Text(state.getDetail.name ?? '',
                style: AppTextTheme.normalBlue),
                SizedBox(height: 8),
                Text(
                '${state.getDetail.name ?? ''}',
                style: AppTextTheme.mediumBlack,
                maxLines: 2,
                ),
                SizedBox(height: 8),
                Text(
                '${state.getDetail.customerItem?.fullname ?? ''}',
                style: AppTextTheme.normalBlue),
                SizedBox(height: 8),
                Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Container(
                width:
                MediaQuery.of(context).size.width * 1 / 4,
                child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Icon(
                Icons.star,
                color: AppColors.colorSun,
                size: 20,
                ),
                Text('${state.getDetail.avgRating}',
                style: AppTextTheme.normalGrey),
                Text(
                '(${state.getDetail.ratings})',
                style: AppTextTheme.normalGrey,
                )
                ],
                ),
                ),
                Expanded(
                child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Icon(
                Icons.schedule,
                size: 17,
                color: AppColors.grey6,
                ),
                Expanded(
                child: Text(
                '${(state.getDetail.customerItem?.km ?? 0).toStringAsFixed(1)}km - ${state.getDetail.customerItem?.address ?? ''}',
                style: AppTextTheme.normalGrey,
                ),
                ),
                ],
                ),
                ),
                ],
                ),
                SizedBox(
                height: 8,
                ),
                Row(
                children: [
                Spacer(),
                Text(
                '${FormatUtils.formatCurrencyDoubleToString(state.getDetail.priceOld ?? 0)}',
                style: AppTextTheme.smallgreyline.copyWith(
                decoration: TextDecoration.lineThrough)),
                SizedBox(
                width: 4,
                ),
                Text(
                '${FormatUtils.formatCurrencyDoubleToString(state.getDetail.priceNew)}',
                style: AppTextTheme.mediumRed,
                )
                ],
                )
                ],
                ),
                ),
                DemoPageViewTitle(
                onChangeTab: (int index) {
                setState(() {
                _index = index;
                });
                },
                currentIndex: _index,
                ),
                Stack(children: [
                PageContainerDemo(
                index: 0,
                indexSelected: _index,
                child: SingleChildScrollView(
                child: Container(
                color: AppColors.grey3,
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Container(
                margin: EdgeInsets.only(
                left: 16, right: 16, top: 16, bottom: 12),
                padding: EdgeInsets.all(15),
                decoration: const BoxDecoration(
                borderRadius:
                BorderRadius.all(Radius.circular(15)),
                color: Colors.white,
                ),
                child: Row(
                children: [
                SizedBox(
                width: 5,
                ),
                Text(
                'Giảm 300,000 đ khi thanh toán bằng G-Token',
                style: TextStyle(fontSize: 12),
                ),
                ],
                ),
                ),
                Container(
                color: AppColors.white,
                width: MediaQuery.of(context).size.width,
                child: BlocBuilder<DetailProductCubit,
                DetailState>(
                bloc: _detailCubit,
                builder: (_, state) {
                if (state is DetailGotDataState) {
                if (state.getSampleShop.isNotEmpty) {
                return ListViewDisplayProduct(
                haveIcon: false,
                label: HomeConstant.SampleShop,
                productModel: state.getSampleShop,
                onMore: () {
                Routes.instance.navigateTo(
                RouteName.allProductScreen,
                arguments:
                ArgumentAllProductScreen(
                url:
                'productapp/GetProductSampleShop?id=${widget.id}&page=1&pagesize=12&latitude=${injector<AppClient>().header?.lat}&longitude=${injector<AppClient>().header?.lng}',
                title: HomeConstant
                    .SampleShop,
                ));
                },
                );
                }
                return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                StringConst.sameSeller,
                style: AppTextTheme.mediumBlack
                    .copyWith(
                fontWeight: FontWeight.w600,
                ),
                ),
                );
                }
                return Text('false');
                }),
                )
                ],
                ),
                ))),
                PageContainerDemo(
                index: 1,
                indexSelected: _index,
                child: Container(
                child: Image.asset(ImageConstant.mockTopBackGround),
                ),
                ),
                PageContainerDemo(
                index: 2,
                indexSelected: _index,
                child: Container(
                width: double.infinity,
                height: 300,
                child: Center(
                child: Text('Chưa có đánh giá nào về sản phẩm này'),
                ),
                ),
                ),
                ])
                ]);
                }
                return Center(
                child: Text(
                'loix',
                )
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        child: Icon(
          Icons.phone,
          color: Colors.white,
        ),
        onPressed: () {},
        backgroundColor: AppColors.green,
      ),
      bottomNavigationBar: Container(
        color: AppColors.grey2.withOpacity(0.1),
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(5),
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 1 / 2.2 - 12,
                height: 44.0,
                decoration: BoxDecoration(
                    color: AppColors.pink,
                    borderRadius: BorderRadius.circular(8.0)),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.payment,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 6.0,
                      ),
                      Text(
                        'Mua ngay',
                        style: AppTextTheme.normalWhite,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(5),
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 1 / 2.2 - 6,
                height: 44.0,
                decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(8.0)),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(
                        width: 6.0,
                      ),
                      Text(
                        'Thêm vào giỏ hàng',
                        style: AppTextTheme.normalWhite,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
