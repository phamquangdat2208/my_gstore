import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/common/customs/custom_border.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';

class LayoutSelectImageLayoutEmptyImage extends StatelessWidget {
  final Function? onTap;
  final String? text;

  const LayoutSelectImageLayoutEmptyImage({Key? key, this.onTap, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 6),
            height: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0))),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  IconConst.imagePlaceHolder,
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  text ?? '',
                  style: AppTextTheme.normalGrey,
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 6),
            height: double.infinity,
            width: double.infinity,
            child: DashedRect(
              color: AppColors.grey5,
              strokeWidth: 2.0,
              gap: 3.0,
            ),
          )
        ],
      ),
    );
  }
}
