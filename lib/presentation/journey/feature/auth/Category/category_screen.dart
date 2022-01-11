
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gstore/common/constants/app_constant.dart';
import 'package:my_gstore/common/customs/custom_scaffold.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/presentation/injector_container.dart';
import 'package:my_gstore/presentation/journey/feature/auth/Category/Cubit/category_cubit.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/banner_slide_image.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/custom_cache_image_network.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/shimmer/common_shimmer.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  CategoryCubit _categoryCubit = injector<CategoryCubit>();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    decoration: BoxDecoration(
                      color: AppColors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 7.0,
                  alignment: WrapAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 84.0,
                        height: 102.0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            BlocBuilder<CategoryCubit, CategoryState>(
                              bloc: _categoryCubit,
                              builder: (_, state) {
                                if (state is CategoryGettingDataState) {
                                  return CommonShimmer(
                                    numberItem: 0,
                                  );
                                }
                                if (state is CategoryGotDataState &&
                                    state.getBanner.isNotEmpty) {
                                  return BannerSlideImage(
                                    bannerModels: state.getBanner,
                                    height: CommonConstant.heightBanner,
                                    autoPlay: true,
                                    enableInfiniteScroll: true,
                                    fit: BoxFit.cover,
                                    duration: Duration(seconds: 6),
                                  );
                                }
                                return const SizedBox();
                              },
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Xã Hội',
                              textAlign: TextAlign.center,
                              style: AppTextTheme.normalGrey9,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}