import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_gstore/common/argument/argument_send_data.dart';
import 'package:my_gstore/common/constants/app_constant.dart';
import 'package:my_gstore/common/model/banner_model.dart';
import 'package:my_gstore/common/navigation/route_names.dart';
import 'package:my_gstore/common/theme/theme_color.dart';

import '../../../routes.dart';
import 'custom_image_network.dart';

class BannerSlideImage extends StatefulWidget {
  final List<BannerModels>? bannerModels;
  final double? borderRadius;
  final double? height;
  final bool autoPlay;
  final bool revert;
  final Duration? duration;
  final bool enableInfiniteScroll;
  final Function(int index)? onchangePage;
  final BoxFit? fit;
  final Function(BannerModels bannerModel)? onBannerTap;

  const BannerSlideImage(
      {Key? key,
      this.bannerModels,
      this.onBannerTap,
      this.borderRadius = 0,
      this.height,
      this.autoPlay = false,
      this.revert = false,
      this.duration,
      this.enableInfiniteScroll = false,
      this.onchangePage,
      this.fit})
      : super(key: key);

  @override
  _BannerSlideImageState createState() => _BannerSlideImageState();
}

class _BannerSlideImageState extends State<BannerSlideImage> {
  int _currentSlideIndex = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  void _onItemBannerClick(BannerModels banner) {
    if (banner.type == null ||
        banner.type == 0 ||
        banner.linkConverted == null) {
      return;
    }
    switch (banner.type) {
      case CommonConstant.BANNER_TYPE_PRODUCT:
        Routes.instance.navigateTo(RouteName.detailProductScreen,
            arguments: ArgumentDetailProductScreen(
              banner.linkConverted,
            ));
        break;
      // case CommonConstant.BANNER_TYPE_COMPANY:
      //   Routes.instance.navigateTo(RouteName.gshopDetailScreen,
      //       arguments: banner.linkConverted);
      //   break;
    }
    if (widget.onBannerTap != null) {
      widget.onBannerTap!(banner);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.bannerModels?.isEmpty ?? true) {
      return const SizedBox();
    }
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: widget.height ?? 248.0.h,
          child: CarouselSlider(
            options: CarouselOptions(
              initialPage: 0,
              height: double.infinity,
              autoPlay: widget.autoPlay,
              autoPlayAnimationDuration:
                  widget.duration ?? Duration(seconds: 5),
              viewportFraction: 1.0,
              reverse: widget.revert,
              enableInfiniteScroll: widget.enableInfiniteScroll,
              onPageChanged: (index, reason) {
                if (widget.onchangePage != null) {
                  widget.onchangePage!(index);
                }
                setState(() {
                  _currentSlideIndex = index;
                });
              },
            ),
            items: widget.bannerModels!
                .map((BannerModels value) => InkWell(
                      onTap: () {
                        _onItemBannerClick(value);
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: CustomImageNetwork(
                          url: value.pictureUrl,
                          width: double.infinity,
                          height: double.infinity,
                          fit: widget.fit,
                          border: widget.borderRadius,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 0,
          left: 0,
          child: Row(
            children: [
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: map<Widget>(widget.bannerModels!, (index, obj) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: EdgeInsets.symmetric(horizontal: 4.h),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentSlideIndex == index
                          ? AppColors.primaryColor
                          : AppColors.grey4,
                    ),
                  );
                }),
              ),
              Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
