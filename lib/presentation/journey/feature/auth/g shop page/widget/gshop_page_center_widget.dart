import 'package:flutter/material.dart';
import 'package:my_gstore/common/model/user_model.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';

class GShopCenterWidget extends StatelessWidget {
  final UserModel? userModel;

  GShopCenterWidget({Key? key, this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 90,
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: AppColors.grey3,
                borderRadius: BorderRadius.all(Radius.circular(16))
            ),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 9,
                  height: MediaQuery.of(context).size.width / 9,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.pink,
                        AppColors.white,
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${userModel?.totalProduct ?? '0'}',
                    style: AppTextTheme.normalWhite,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  width: MediaQuery.of(context).size.width / 6,
                  child: Text("Mặt hàng",style: AppTextTheme.smallGrey, textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
          Container(
            height: 90,
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: AppColors.grey3,
                borderRadius: BorderRadius.all(Radius.circular(16))
            ),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 9,
                  height: MediaQuery.of(context).size.width / 9,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          AppColors.colorSun,
                          AppColors.rent,
                        ],
                      )),
                  alignment: Alignment.center,
                  child: Text(
                    '${userModel?.totalProductView ?? '0'}',
                    style: AppTextTheme.normalWhite,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  width: MediaQuery.of(context).size.width / 6,
                  child: const Text("Lượt xem",style: AppTextTheme.smallGrey, textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
          Container(
            height: 90,
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: AppColors.grey3,
                borderRadius: BorderRadius.all(Radius.circular(16))
            ),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 9,
                  height: MediaQuery.of(context).size.width / 9,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          AppColors.lightGreen,
                          AppColors.logoGreen,
                        ],
                      )),
                  alignment: Alignment.center,
                  child: Text(
                    '${userModel?.totalOrder ?? '0'}',
                    style: AppTextTheme.normalWhite,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  width: MediaQuery.of(context).size.width / 6,
                  alignment: Alignment.center,
                  child: const Text(
                    "Đơn đã bán",style: AppTextTheme.smallGrey,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 90,
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.grey3,
              borderRadius: BorderRadius.all(Radius.circular(16))
            ),
            width: MediaQuery.of(context).size.width / 6,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 9,
                  height: MediaQuery.of(context).size.width / 9,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          AppColors.logoSkyBlue,
                          Colors.lightBlue,
                        ],
                      )),
                  alignment: Alignment.center,
                  child: Text(
                    '${userModel?.likeTotal ?? '0'}',
                    style: AppTextTheme.normalWhite,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  width: MediaQuery.of(context).size.width / 6,
                  alignment: Alignment.center,
                  child: const Text("Người yêu thích",style: AppTextTheme.smallGrey,
                      textAlign: TextAlign.center),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
