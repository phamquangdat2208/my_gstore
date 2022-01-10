import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_gstore/common/constants/login_constant.dart';
import 'package:my_gstore/common/theme/theme_text.dart';

class ButtonBottom extends StatelessWidget {
  final Color? color;
  final Function? onTap;
  final String? text;
  final String? urlIcon;
  final bool? haveIcon;
  final double? paddingHorizontal;
  final TextStyle? textStyle;

  const ButtonBottom({
    Key? key,
    this.color,
    this.onTap,
    this.text,
    this.urlIcon,
    this.textStyle,
    this.haveIcon = true,
    this.paddingHorizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
        height: 48.0,
        width: double.infinity,
        margin: EdgeInsets.symmetric(
            horizontal:
                paddingHorizontal ?? LoginConstant.marginHorizontalButton.w),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (haveIcon ?? false)
                ? SvgPicture.asset(
                    urlIcon ?? '',
                    width: 20.0,
                    height: 20.0,
                  )
                : const SizedBox(),
            SizedBox(width: (haveIcon ?? false) ? 6.0 : 0),
            Text(
              text ?? '',
              style: textStyle ?? AppTextTheme.medium,
            ),
          ],
        ),
      ),
    );
  }
}
