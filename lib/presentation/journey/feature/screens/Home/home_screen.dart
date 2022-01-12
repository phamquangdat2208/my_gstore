import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gstore/common/constants/home_constant.dart';
import 'package:my_gstore/common/global_app_cache/global_app_catch.dart';
import 'package:my_gstore/common/navigation/route_names.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/presentation/injector_container.dart';
import 'package:my_gstore/presentation/journey/feature/auth/all%20product/all_product_page.dart';
import 'package:my_gstore/presentation/journey/feature/screens/Home/component/custom_sliver_appbar_home.dart';
import 'package:my_gstore/presentation/journey/feature/screens/Home/component/home_center.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/G%20Shop%20Items/listview_gshop.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/Product%20Item/listview_product.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/custom_cache_image_network.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/gridview_product.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/shimmer/common_shimmer.dart';
import '../../../../routes.dart';
import 'component/home_map.dart';
import 'cubit/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // int _current = 0;
  HomeCubit _homeCubit = injector<HomeCubit>();
  ScrollController _controller = ScrollController();
  void initState() {
    _homeCubit.getInitData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        controller: _controller,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPersistentHeader(
              pinned: true,
              delegate: CustomSliverAppbarHome(
                  profileModel: injector<GlobalAppCache>().profileModel)),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const HomeMapComponent(),
                Row(
                  children: const [
                    HomeCenter(),
                  ],
                ),
                BlocBuilder<HomeCubit, HomeState>(
                  bloc: _homeCubit,
                  builder: (_, state) {
                    if (state is HomeGettingDataState) {
                      return CommonShimmer(
                        numberItem: 2,
                      );
                    }
                    if (state is HomeGotDataState &&
                        state.getGShop.isNotEmpty) {
                      return ListViewDisplayGShop(
                        label: HomeConstant.gShop,
                        information: state.getGShop,
                        onMore: () {
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
                BlocBuilder<HomeCubit, HomeState>(
                  bloc: _homeCubit,
                  builder: (_, state) {
                    if (state is HomeGettingDataState) {
                      return CommonShimmer(
                        numberItem: 0,
                      );
                    }
                    if (state is HomeGotDataState &&
                        state.getGShop.isNotEmpty) {
                      return CarouselSlider(
                        options: CarouselOptions(
                            onPageChanged: (index, other) {
                              setState(() {
                              });
                            },
                            autoPlayInterval: Duration(seconds: 4),
                            autoPlayAnimationDuration: Duration(seconds: 3),
                            viewportFraction: 1,
                            autoPlay: true),
                        items: state.getBanner
                            .map((banner) => ClipRRect(
                          child: CustomCacheImageNetwork(
                            height: MediaQuery.of(context).size.height*1/5+20,
                           url:  banner.pictureUrl??'',
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ))
                            .toList(),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                BlocBuilder<HomeCubit, HomeState>(
                  bloc: _homeCubit,
                  builder: (_, state) {
                    if (state is HomeGettingDataState) {
                      return CommonShimmer(
                        numberItem: 0,
                      );
                    }
                    if (state is HomeGotDataState &&
                        state.getGShop.isNotEmpty) {
                      return ListViewDisplayProduct(
                        haveIcon: false,
                        label: HomeConstant.bestBuy,
                        productModel: state.getBestBuy,
                        onMore: () {
                          Routes.instance.navigateTo(RouteName.allProductScreen,
                              arguments: ArgumentAllProductScreen(
                                  url: 'productapp/GetBestBuyNew?page=1&pagesize=12',
                                  title: HomeConstant.bestBuy,
                                 ));
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
                BlocBuilder<HomeCubit, HomeState>(
                  bloc: _homeCubit,
                  builder: (_, state) {
                    if (state is HomeGettingDataState) {
                      return CommonShimmer(
                        numberItem: 0,
                      );
                    }
                    if (state is HomeGotDataState &&
                        state.getBestBuyNew.isNotEmpty) {
                      return GridViewDisplayProduct(
                        label: HomeConstant.suggestToday,
                        courses: state.getBestBuyNew,
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}

