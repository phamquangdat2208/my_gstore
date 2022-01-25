import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';


class IconBorderBackGroundBlackOparity extends StatelessWidget {
  final String? icon;
  final Function? onTap;
  final double? opacity;
  final bool? iconCart;
  final int? number;

  const IconBorderBackGroundBlackOparity({
    Key? key,
    this.icon,
    this.onTap,
    this.opacity,
    this.iconCart = false,
    this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Stack(
              children: [
                Opacity(
                  opacity: opacity ?? 1,
                  child: Container(
                    width: 32.0,
                    height: 32.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  width: 32.0,
                  height: 32.0,
                  child: Center(
                    child: SvgPicture.asset(
                      icon ?? '',
                      fit: BoxFit.cover,
                      width: 20.0,
                      color: AppColors.white,
                      height: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: ((iconCart ?? false) && number != null)
                ? Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
              child: Center(
                child: Text(
                  '$number',
                  style: AppTextTheme.normalGrey
                      .copyWith(color: AppColors.red6, fontSize: 12),
                ),
              ),
            )
                : SizedBox(),
          )
        ],
      ),
    );
  }
}
