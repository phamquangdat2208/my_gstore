import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_gstore/common/theme/theme_color.dart';

// tự custom icon
class PersonalItemCustom extends StatelessWidget {
  final String? icon;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? height;
  final double? width;
  const PersonalItemCustom(
      {Key? key,
        this.icon,
        this.backgroundColor = AppColors.grey3,
        this.iconColor,
        this.height,
        this.width,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: (icon?.contains('svg') ?? true)
                ? (iconColor != null
                ? SvgPicture.asset(
              icon ?? '',
              width: width,
              height: height,
              color: iconColor,
            )
                : SvgPicture.asset(
              icon ?? '',
              width: width,
              height: height,
            ))
                : Image.asset(
              icon ?? '',
              width: 20,
              height: 20,
              color: iconColor ?? AppColors.white,
            ),
          ),
        );
  }
}
