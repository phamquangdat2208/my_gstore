import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/common/ultils/common_util.dart';
import 'package:shimmer/shimmer.dart';

class CustomImageNetwork extends StatelessWidget {
  final String? url;
  final double width;
  final double height;
  final BoxFit? fit;
  final double? border;
  final double? paddingPlaceHolder;
  final String? userName;
  final TextStyle? styleUserName;

  const CustomImageNetwork({
    Key? key,
    this.url,
    this.width = 40,
    this.height = 40,
    this.fit,
    this.paddingPlaceHolder,
    this.border,
    this.userName,
    this.styleUserName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if ((url?.isNotEmpty ?? false) && (url?.contains('http') ?? false)) {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(border ?? 0)),
        child: Image.network(
          url ?? '',
          fit: fit,
          width: width,
          height: height,
          errorBuilder: (
            BuildContext? context,
            Object? error,
            StackTrace? stackTrace,
          ) {
            return _widgetImagePlaceHolder();
          },
          loadingBuilder: (
            BuildContext? context,
            Widget? child,
            ImageChunkEvent? loadingProgress,
          ) {
            if (loadingProgress == null) {
              return child ?? const SizedBox();
            }
            return Shimmer.fromColors(
              baseColor: Color(0xFFE0E0E0),
              highlightColor: Color(0xFFF5F5F5),
              enabled: true,
              child: Container(
                width: width,
                height: height,
                color: AppColors.white,
              ),
            );
          },
        ),
      );
    }
    if (userName?.isNotEmpty ?? false) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: AppColors.grey4, width: 0.5),
        ),
        padding: EdgeInsets.all(width / 6),
        child: Center(
          child: Text(
            CommonUtils.getTwoCharOfName(userName),
            style: styleUserName ??
                AppTextTheme.title.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
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
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: AppColors.grey4),
        ),
        padding: EdgeInsets.all(paddingPlaceHolder ?? 16),
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
