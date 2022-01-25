import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_gstore/common/constants/app_constant.dart';
import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/common/constants/image_constant.dart';
import 'package:my_gstore/common/customs/custom_gesturedetactor.dart';
import 'package:my_gstore/common/model/detail_product_model.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/common/ultils/screen_utils.dart';
import 'package:my_gstore/presentation/journey/feature/auth/g%20shop%20page/widget/icon_border_background_black_opacity.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/custom_cache_image_network.dart';

import '../../../../../routes.dart';

double heightSliver = 350.0;

class ProductDetailSliverAppBar extends SliverPersistentHeaderDelegate {
  final DataProduct? product;
  final Function moveToCart;
  final Function onIconMoreTap;
  final Function onFavourite;
  final Function onShare;

  ProductDetailSliverAppBar(
      {required this.onFavourite,
      required this.product,
      required this.onShare,
      required this.moveToCart,
      required this.onIconMoreTap});

  double scrollAnimationValue(double shrinkOffset) {
    double maxScrollAllowed = maxExtent - minExtent;
    return ((maxScrollAllowed - shrinkOffset) / maxScrollAllowed)
        .clamp(0, 1)
        .toDouble();
  }
  String? icon;
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double animationVal =
        max(0, 2 * scrollAnimationValue(shrinkOffset) - 1);
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: CustomCacheImageNetwork(
            height: 350,
            width: double.infinity,
            url: product?.urlPicture ?? '',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: maxExtent,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Stack(
                  children: [
                    Opacity(
                      opacity: 1 - animationVal,
                      child: Container(
                        width: double.infinity,
                        height: CommonConstant.defaultAppbar +
                            GScreenUtil.statusBarHeight,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: CommonConstant.defaultAppbar +
                          GScreenUtil.statusBarHeight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height:
                                GScreenUtil.statusBarHeight + 12 * animationVal,
                          ),
                          Row(
                            children: [
                              SizedBox(width: 12),
                              IconBorderBackGroundBlackOparity(
                                opacity: animationVal,
                                onTap: () {
                                  Routes.instance.pop();
                                },
                                icon: IconConst.iconClose,
                              ),
                              SizedBox(width: 6),
                              Expanded(
                                child: Opacity(
                                  opacity: 1 - animationVal,
                                  child: Text(
                                    product?.name ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextTheme.mediumBlack.copyWith(
                                        height: 1.4, color: AppColors.white),
                                  ),
                                ),
                              ),
                              IconBorderBackGroundBlackOparity(
                                opacity: animationVal,
                                onTap: () {
                                  // Routes.instance.pop();
                                },
                                icon: IconConst.productCart,
                              ),

                              IconBorderBackGroundBlackOparity(
                                opacity: animationVal,
                                onTap: () {

                                  onFavourite(icon == null);
                                },
                                icon: icon ?? IconConst.favorite,
                              ),
                              IconBorderBackGroundBlackOparity(
                                opacity: animationVal,
                                onTap: () {
                                  // Routes.instance.pop();
                                },
                                icon: IconConst.more,
                              ),
                              SizedBox(width: 16),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => heightSliver;

  @override
  double get minExtent =>
      CommonConstant.defaultAppbar + GScreenUtil.statusBarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
