import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_gstore/common/constants/app_constant.dart';
import 'package:my_gstore/common/model/product_model.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/ultils/common_util.dart';
import 'package:my_gstore/common/ultils/screen_utils.dart';

double heightSliver = 414.0.h;

class DetailProductCustomSliverAppbar extends SliverPersistentHeaderDelegate {
  // final DetailProductBloc detailProductBloc;
  final ProductModel? productEntity;
  final Function onClose;
  final Function moveToCart;
  final Function(BuildContext context) onIconMoreTap;
  final Function(bool setFavourite) onFavourite;

  DetailProductCustomSliverAppbar(
      {required this.onFavourite,
      this.productEntity,
      required this.onClose,
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
    final double visibleMainHeight = max(maxExtent - shrinkOffset, minExtent);
    final double animationVal =
        max(0, 2 * scrollAnimationValue(shrinkOffset) - 1);
    return Container(
      height: heightSliver,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          PreferredSize(
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
                            child: Icon(
                              Icons.shopping_cart,
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
          Positioned(
            child: CommonUtils.mapLevelUserToWidget(productEntity?.numberTS),
            right: 16,
            bottom: 12,
          )
        ],
      ),
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
