import 'package:flutter/material.dart';
import 'package:my_gstore/common/constants/home_constant.dart';
import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';

class LayoutTopSearchInHomeScreen extends StatelessWidget {
  final Function? onTapSelectCity;
  final Function? onSearch;
  final bool haveShadow;

  const LayoutTopSearchInHomeScreen(
      {Key? key, this.onTapSelectCity, this.onSearch, this.haveShadow = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onSearch!();
      },
      child: Container(
        // width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          color: Colors.white,
          boxShadow: [
            haveShadow
                ? BoxShadow(color: Colors.white, offset: Offset(0, 0))
                : BoxShadow(
                    color: AppColors.grey300,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 12.0),
            Image.asset(
              IconConst.search,
              width: 15.0,
              height: 15.0,
              color: AppColors.grey7,
            ),
            const SizedBox(width: 6),
            const Text(
              HomeConstant.whatYourNeed,
              style: AppTextTheme.normalGrey,
            ),
          ],
        ),
      ),
    );
  }
}
