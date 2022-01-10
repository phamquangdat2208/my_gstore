import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_gstore/common/constants/app_constant.dart';
import 'package:my_gstore/common/constants/image_constant.dart';
import 'package:my_gstore/common/global_app_cache/global_app_catch.dart';
import 'package:my_gstore/common/model/profile_model.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/common/ultils/common_util.dart';
import 'package:my_gstore/common/ultils/screen_utils.dart';
import 'package:my_gstore/presentation/injector_container.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/custom_cache_image_network.dart';

import 'layout_textfield_search.dart';

class CustomSliverAppbarHome extends SliverPersistentHeaderDelegate {
  final ProfileModel? profileModel;

  CustomSliverAppbarHome({this.profileModel});
  double scrollAnimationValue(double shrinkOffset) {
    double maxScrollAllowed = maxExtent - minExtent;
    return ((maxScrollAllowed - shrinkOffset) / maxScrollAllowed)
        .clamp(0, 1)
        .toDouble();
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double visibleMainHeight = max(maxExtent - shrinkOffset, minExtent);
    final double animationVal = scrollAnimationValue(shrinkOffset);

    return Container(
      height: visibleMainHeight,
      width: MediaQuery.of(context).size.width,
      color: AppColors.primaryColor,
      child: Stack(
        children: [
          Column(
            children: [
              Opacity(
                opacity: animationVal,
                child: profileModel?.imageTimeline != null
                    ? CustomCacheImageNetwork(
                        url: profileModel?.imageTimeline ?? '',
                        height: visibleMainHeight - 30,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        ImageConstant.mockTopBackGround,
                        height: visibleMainHeight - 30,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
              Stack(
                children: [
                  Container(
                    height: 30,
                    width: double.infinity,
                    color: animationVal == 0
                        ? AppColors.primaryColor
                        : AppColors.grey3,
                  ),
                  Opacity(
                    opacity: 1 - animationVal,
                    child: Container(
                      width: double.infinity,
                      height: 30 * (1 - animationVal),
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: CommonUtils.textHelloInHome(),
                            style: AppTextTheme.normalWhite
                                .copyWith(fontSize: 18.0)),
                        TextSpan(
                            text: injector<GlobalAppCache>().haveLoggedIn
                                ? ' ${profileModel?.fullName ?? ''}'
                                : '',
                            style: AppTextTheme.normalWhite.copyWith(
                                fontSize: 18.0, fontWeight: FontWeight.bold)),
                      ])),
                      const SizedBox(
                        height: 8.0,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 8, right: 16.0, left: 16.0),
                child: LayoutTopSearchInHomeScreen(
                  // onSearch: startSearch,
                  // onTapSelectCity: navigateToSelectCity,
                  haveShadow: animationVal == 0,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => CommonConstant.heightTimeLine + 30;

  @override
  double get minExtent => 78.0 + GScreenUtil.statusBarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
