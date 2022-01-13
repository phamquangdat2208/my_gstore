import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gstore/common/constants/app_constant.dart';
import 'package:my_gstore/common/constants/home_constant.dart';
import 'package:my_gstore/common/customs/custom_gesturedetactor.dart';
import 'package:my_gstore/common/customs/custom_scaffold.dart';
import 'package:my_gstore/common/model/category_model.dart';
import 'package:my_gstore/common/navigation/route_names.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/presentation/injector_container.dart';

import 'package:my_gstore/presentation/journey/feature/auth/all%20product/all_product_page.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/banner_slide_image.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/custom_cache_image_network.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/shimmer/common_shimmer.dart';

import '../../../../routes.dart';
import 'Cubit/category_cubit.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int _current = 1;
  CategoryCubit _categoryCubit = injector<CategoryCubit>();

  @override
  void initState() {
    _categoryCubit.getInitData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // banner going.........
          BlocBuilder(
              bloc: _categoryCubit,
              builder: (_, state) {
                if (state is CategoryGettingDataState) {
                  return CommonShimmer(
                    numberItem: 1,
                  );
                }
                if (state is CategoryGotDataState &&
                    state.getBanner.isNotEmpty) {
                  return Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: CarouselSlider(
                          options: CarouselOptions(
                              onPageChanged: (index, other) {
                                setState(() {
                                  _current = index + 1;
                                });
                              },
                              viewportFraction: 1,
                              autoPlay: true),
                          items: state.getBanner
                              .map((banner) => ClipRRect(
                                    // borderRadius: BorderRadius.circular(8),
                                    child: CustomCacheImageNetwork(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              1 /
                                              4,
                                      url: banner.pictureUrl ?? '',
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          alignment: Alignment.center,
                          height: 24,
                          width: 38,
                          decoration: const BoxDecoration(
                              color: Colors.white70,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Text(
                            "$_current/${state.getBanner.length}",
                            style: AppTextTheme.mediumBlack,
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return const Text("Đang lấy data!");
              }),

          // list cac danh muc...........
          BlocBuilder(
              bloc: _categoryCubit,
              builder: (_, state) {
                if (state is CategoryGettingDataState) {
                  return const SizedBox();
                }
                if (state is CategoryGotDataState &&
                    state.getCategories.isNotEmpty) {
                  List<CategoryModel> categories = state.getCategories
                      .where((element) => element.parentId == 1)
                      .toList();
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 1,
                      ),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) =>
                          ItemCard(item: categories[index]),
                      itemCount: categories.length,
                    ),
                  );
                }
                return const Text("Đang lấy data!");
              })
        ],
      ),
    ));
  }
}

class ItemCard extends StatelessWidget {
  final CategoryModel item;

  const ItemCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Container(
          height: 130,
          width: 84,
          alignment: Alignment.center,
          child: Column(
            children: [
              item.urlPicture ==''
                  ? CustomGestureDetector(
                      onTap: () {
                        Routes.instance.navigateTo(RouteName.allProductScreen,
                            arguments: ArgumentAllProductScreen(
                              url:
                                  'productapp/GetProductForMapElasticNew?name=&minKm=&maxKm=0&cateId=${item.iD}&minPrice=0&maxPrice=0&latitude=21.030235&longitude=105.761697&page=1&pagesize=12&isGstore=ALL',
                              title: item.name,
                            ));
                      },
                      child: Container(
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            color: AppColors.lightGreen,
                          ),
                          margin: const EdgeInsets.only(
                              top: 16, left: 22, right: 22),
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.home,
                            color: AppColors.white,
                          )),
                    )
                  : CustomGestureDetector(
                      onTap: () {
                        Routes.instance.navigateTo(RouteName.allProductScreen,
                            arguments: ArgumentAllProductScreen(
                              url:
                                  'productapp/GetProductForMapElasticNew?name=&minKm=&maxKm=0&cateId=${item.iD}&minPrice=0&maxPrice=0&latitude=21.030235&longitude=105.761697&page=1&pagesize=12&isGstore=ALL',
                              title: item.name,
                            ));
                      },
                      child: Container(
                        color: AppColors.white,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: CustomCacheImageNetwork(
                            url: item.urlPicture ?? '',
                            height: 50,
                            width: 50,
                          ),
                        ),
                      ),
                    ),
              Container(
                width: 84,
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  item.name ?? '',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
        ));
  }
}
