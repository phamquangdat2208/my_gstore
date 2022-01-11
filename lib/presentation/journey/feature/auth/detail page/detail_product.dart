import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gstore/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:my_gstore/common/bloc/loading_bloc/loading_event.dart';
import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:my_gstore/common/constants/string_const.dart';
import 'package:my_gstore/common/model/detail_product_model.dart';
import 'package:my_gstore/common/network/app_client.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/common/ultils/common_util.dart';
import 'package:my_gstore/common/ultils/format_utils.dart';
import 'package:my_gstore/presentation/journey/feature/auth/detail%20page/cubit/detail_cubit.dart';
import 'package:my_gstore/presentation/journey/feature/auth/detail%20page/page_container_demo/demo_pageview_title.dart';
import 'package:my_gstore/presentation/journey/feature/auth/detail%20page/page_container_demo/page_container_demo.dart';

import 'package:my_gstore/presentation/journey/feature/widgets/custom_cache_image_network.dart';


import '../../../../injector_container.dart';
import '../../../../routes.dart';

class ProductDetailPage extends StatefulWidget {
  int? id;

  ProductDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  // DetailProductCubit _detailCubit = injector<DetailProductCubit>();
  DetailProductModel? _detailProductModel;
  int _currentindex = 0;

  @override
  void initState() {
    _initData();
    super.initState();
  }

  void _initData() async {
    try {
      injector<LoadingBloc>().add(StartLoading());
      final data = await injector<AppClient>().get(
          'ProductApp/GetById?id=${widget.id}&latitude=21.030235&longitude=105.761697');
      _detailProductModel = DetailProductModel.fromJson(data['Data']);
      setState(() {});
    } catch (e) {
      CommonUtils.handleException(injector<SnackBarBloc>(), e,
          methodName: 'getThemes DetailProduct');
      Routes.instance.pop();
    } finally {
      injector<LoadingBloc>().add(FinishLoading());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(250.0),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
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
                          Icons.close,
                          color: Colors.white,
                          size: 18,
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
      body:SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child:Column(
          children: [
            // BlocBuilder<DetailProductCubit, DetailState>(
            //   bloc: _detailCubit,
            //   builder: (_, state) {
            //     if(state is DetailGettingDataState){
            //       return CommonShimmer(
            //         numberItem: 0,
            //       );
            //     }
            //     if(state is DetailGotDataState && state.getDetail.isNotEmpty){
            //       return
            //     }
            //     return const SizedBox(height: 50,child: Text('lỗi'),);
            //   },
            // ),
        // ),
        //     SlideImage(
        //       urls: _detailProductModel?.lstPictures
        //           ?.map((e) => e.url ?? '')
        //           .toList() ??
        //           [],
        //       borderRadius: 8,
        //       fit: BoxFit.cover,
        //       height: 300,
        //     ),
            CustomCacheImageNetwork(
              url: _detailProductModel?.urlPicture ?? '',
              height: MediaQuery.of(context).size.height*1/2,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              padding: EdgeInsets.all(8),
              width: double.infinity,
              height: 210,
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
                  Text('${_detailProductModel?.categoryName ?? ''}',
                      style: AppTextTheme.normalBlue),
                  SizedBox(height: 8),
                  Text('${_detailProductModel?.name ?? ''}',
                      style: AppTextTheme.mediumBlack,maxLines: 2,),
                  SizedBox(height: 8),
                  Text('${_detailProductModel?.customerItem?.fullname ?? ''}',
                      style: AppTextTheme.normalBlue),
                  SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 1 / 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.star,
                              color: AppColors.colorSun,
                              size: 20,
                            ),
                            Text('${_detailProductModel?.avgRating}',
                                style: AppTextTheme.normalGrey),
                            Text(
                              '(${_detailProductModel?.ratings})',
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
                                '${(_detailProductModel?.customerItem?.km ?? 0).toStringAsFixed(1)}km - ${_detailProductModel?.customerItem?.address ?? ''}',
                                style: AppTextTheme.normalGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Text('${FormatUtils.formatCurrencyDoubleToString(_detailProductModel?.priceOld??0)}',style:AppTextTheme.smallgreyline.copyWith(decoration: TextDecoration.lineThrough) ),
                      Text(
                       ' ${ FormatUtils.formatCurrencyDoubleToString(
    _detailProductModel?.priceNew)}',
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
                  _currentindex = index;
                });
              },
              currentIndex: _currentindex,
            ),
            Stack(
              children: [
                PageContainerDemo(
                    index: 0,
                    indexSelected: _currentindex,
                    child: SingleChildScrollView(
                      child: Container(
                        color: AppColors.grey3,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: 15, right: 15, top: 15, bottom: 10),
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
                              margin: EdgeInsets.only(
                                  left: 15, right: 15, bottom: 15),
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
                                    'Miễn phí vận chuyển với đơn hàng trên 1,000,000 đ',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              padding: const EdgeInsets.all(16),
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    StringConst.descriptionProduct,
                                    style: AppTextTheme.mediumBlack,
                                  ),
                                  const SizedBox(height: 8),
                                  Text('${_detailProductModel?.description}')
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width,
                              height: 320,
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 16, left: 16, right: 16),
                                    child: Row(
                                      children: [
                                        const Text(
                                          StringConst.sameSeller,
                                          style: AppTextTheme.mediumBlack,
                                        ),
                                        Expanded(child: Container()),
                                        const Text(
                                          StringConst.all,
                                          style: AppTextTheme.normalBlue,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  Text(
                                    StringConst.sameProduct,
                                    style: AppTextTheme.mediumBlack,
                                  ),
                                  Spacer(),
                                  Text(
                                    StringConst.all,
                                    style: AppTextTheme.normalBlue,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                PageContainerDemo(
                  index: 1,
                  indexSelected: _currentindex,
                  child: Container(
                    color: AppColors.red,
                  ),
                ),
                PageContainerDemo(
                  index: 2,
                  indexSelected: _currentindex,
                  child: Container(
                    width: double.infinity,
                    height: 300,
                    child: Center(
                      child: Text('Chưa có đánh giá nào về sản phẩm này'),
                    ),
                  ),
                ),
              ],
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
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width * 1 / 2.2,
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
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width * 1 / 2.2,
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
                      ),
                      SizedBox(
                        width: 6.0,
                      ),
                      Text(
                        'Thêm vào giỏ hàng',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500),
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
