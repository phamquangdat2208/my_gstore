import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_gstore/common/constants/app_constant.dart';
import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/common/constants/image_constant.dart';
import 'package:my_gstore/common/customs/custom_gesturedetactor.dart';
import 'package:my_gstore/common/model/user_model.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/common/ultils/screen_utils.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/custom_cache_image_network.dart';
import '../../../../../routes.dart';
import 'gshop_page_center_widget.dart';

double heightSliver = 450.0;

class GShopDetailSliverAppBar extends SliverPersistentHeaderDelegate {
  final UserModel gshop;
  final Function moveToCart;
  final Function onIconMoreTap;
  final Function onFavourite;
  final Function onShare;

  GShopDetailSliverAppBar(
      {required this.onFavourite,
      required this.gshop,
      required this.onShare,
      required this.moveToCart,
      required this.onIconMoreTap});

  double scrollAnimationValue(double shrinkOffset) {
    double maxScrollAllowed = maxExtent - minExtent;
    return ((maxScrollAllowed - shrinkOffset) / maxScrollAllowed)
        .clamp(0, 1)
        .toDouble();
  }

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
            url: gshop?.avatar ?? '',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: maxExtent,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Image.asset(
                  IconConst.gDetailBackground,
                  height: maxExtent,
                  width: GScreenUtil.screenWidthDp,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  bottom: 100,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16),
                        Text(
                          gshop?.fullname ?? '',
                          style: AppTextTheme.medium20PxBlack
                              .copyWith(color: AppColors.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5),
                        Text(
                          gshop?.address ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextTheme.style12pxGrey
                              .copyWith(color: AppColors.white),
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            SizedBox(width: 1.5),
                            RatingBarIndicator(
                              rating: 1,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: AppColors.white,
                              ),
                              itemCount: 1,
                              itemSize: 12.0,
                              direction: Axis.horizontal,
                            ),
                            SizedBox(width: 1.5),
                            // IconStar(),
                            Text(
                                '${gshop?.avgRating ?? 0.0}(${gshop?.ratings ?? 0})',
                                style: AppTextTheme.style12pxGrey
                                    .copyWith(color: AppColors.white)),
                            SizedBox(width: 17.0),
                            SvgPicture.asset(
                              IconConst.iconClock,
                              width: 14.0,
                              height: 14.0,
                              color: AppColors.white,
                            ),
                            SizedBox(width: 5.0),
                            Expanded(
                              child: Text(
                                '${gshop?.kmText ?? ''}km',
                                style: AppTextTheme.style12pxGrey
                                    .copyWith(color: AppColors.white),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.0),
                      ],
                    ),
                  )),
              Positioned(
                  bottom: 0,
                  child: Container(
                    width: GScreenUtil.screenWidthDp,
                    height: 100,
                    padding: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                      color: AppColors.white,
                    ),
                    child: GShopCenterWidget(userModel: gshop),
                  )),
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
                              CustomGestureDetector(
                                  onTap: () {
                                    Routes.instance.pop();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(
                                      Icons.keyboard_arrow_left,
                                      color: AppColors.white,
                                      size: 35,
                                    ),
                                  )),
                              SizedBox(width: 6),
                              Expanded(
                                child: Opacity(
                                  opacity: 1 - animationVal,
                                  child: Text(
                                    gshop?.fullname ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextTheme.mediumBlack.copyWith(
                                        height: 1.4, color: AppColors.white),
                                  ),
                                ),
                              ),
                              CustomGestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        IconConst.share,
                                        fit: BoxFit.cover,
                                        width: 22,
                                        height: 22,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 42.0,
                                height: 42.0,
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: SvgPicture.asset(
                                    ImageConstant.logo,
                                    fit: BoxFit.cover,
                                    width: 35.0,
                                    height: 35.0,
                                  ),
                                ),
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
