import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_gstore/common/constants/gif_constant.dart';
import 'package:my_gstore/common/constants/string_const.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
class FavouriteCartScreen extends StatelessWidget {
  const FavouriteCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: 250,
              width:250,
              child: LottieBuilder.asset(GifConst.favoriteItem,repeat: false,)),
          Text(StringConst.NoFavoriteItem,style: AppTextTheme.normalGrey,),
          SizedBox(height: 8,),
          Text(StringConst.discover,style: AppTextTheme.smallGreen,)
        ],
      ),
    );
  }
}
