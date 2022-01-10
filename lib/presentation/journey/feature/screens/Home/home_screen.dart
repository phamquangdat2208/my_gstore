import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/common/global_app_cache/global_app_catch.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/presentation/injector_container.dart';
import 'package:my_gstore/presentation/journey/feature/screens/Home/component/custom_sliver_appbar_home.dart';
import 'package:my_gstore/presentation/journey/feature/screens/Home/component/home_center.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/G%20Shop%20Items/listview_gshop.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/gridview_product.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/Product%20Item/listview_product.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/shimmer/common_shimmer.dart';
import 'component/home_map.dart';
import 'cubit/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                HomeMapComponent(),
                Row(
                  children: [
                    HomeCenter(),
                  ],
                ),
                BlocBuilder<HomeCubit, HomeState>(
                  bloc: _homeCubit,
                  builder: (_, state) {
                    if (state is HomeGettingDataState) {
                      return CommonShimmer(
                        numberItem: 5,
                      );
                    }
                    if (state is HomeGotDataState &&
                        state.getGShop.isNotEmpty) {
                      return ListViewDisplayGShop(
                        label: 'G-Shop',
                        information: state.getGShop,
                        onMore: () {
                          // Routes.instance.navigateTo(RouteName.AllCourseScreen,
                          //     arguments: ArgumentAllCourseScreen(
                          //         url: 'get-edu-courses-hot',
                          //         title: 'Khoá học đang hot',
                          //         haveIconHot: true));
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
                        numberItem: 5,
                      );
                    }
                    if (state is HomeGotDataState &&
                        state.getBestBuyNew.isNotEmpty) {
                      return GridViewDisplayProduct(
                        label: 'Gần tôi',
                        courses: state.getBestBuyNew,
                        onMore: () {
                          // Routes.instance.navigateTo(RouteName.AllCourseScreen,
                          //     arguments: ArgumentAllCourseScreen(
                          //         url: 'get-edu-courses-hot',
                          //         title: 'Khoá học đang hot',
                          //         haveIconHot: true));
                        },
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

