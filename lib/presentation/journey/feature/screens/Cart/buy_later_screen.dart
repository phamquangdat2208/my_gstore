import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_gstore/common/constants/gif_constant.dart';
import 'package:my_gstore/common/constants/string_const.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
class BuyLaterScreen extends StatelessWidget {
  const BuyLaterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: 300,
              width:300,
              child: LottieBuilder.asset(GifConst.motordelivery)),
            Text(StringConst.noProductsYet,style: AppTextTheme.mediumGrey,)
        ],
      ),
    );
  }
}
