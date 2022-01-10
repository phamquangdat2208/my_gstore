import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/common/ultils/common_util.dart';

import 'package:shimmer/shimmer.dart';

class CustomCacheImageNetwork extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final double? border;

  // nếu có userName và url Empty thì sẽ hiện thị ảnh chưa 2 chữ cái trong tên
  final String? userName;

  const CustomCacheImageNetwork({
    Key? key,
    required this.url,
    this.width = 40,
    this.height = 40,
    this.fit,
    this.border,
    this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url.isNotEmpty && url.contains('http')) {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(border ?? 0)),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: url,
              fit: fit,
              width: width,
              height: height,
              errorWidget: (_, url, error) => _widgetImagePlaceHolder(),
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: AppColors.grey300,
                highlightColor: AppColors.grey100,
                enabled: true,
                child: Container(
                  width: width,
                  height: height,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      );
    }
    if ((userName?.isNotEmpty ?? false)) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: AppColors.grey4, width: 0.5),
        ),
        padding: EdgeInsets.all(16),
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    spreadRadius: 3,
                    blurRadius: 5)
              ],
              color: AppColors.white),
          child: Center(
            child: Text(
              CommonUtils.getTwoCharOfName(userName),
              style: AppTextTheme.title.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
      );
    }
    return _widgetImagePlaceHolder();
  }

  Widget _widgetImagePlaceHolder() => Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: AppColors.grey6,
      borderRadius: BorderRadius.all(Radius.circular(8)),
      border: Border.all(color: AppColors.grey4),
    ),
    padding: EdgeInsets.all(16),
    child: Center(
      child: SvgPicture.asset(
        IconConst.imagePlaceHolder,
        width: double.infinity,
        height: double.infinity,
        color: AppColors.grey4,
      ),
    ),
  );
}
