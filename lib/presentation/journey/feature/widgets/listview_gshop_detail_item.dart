import 'package:flutter/material.dart';
import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/common/model/gshop_model.dart';
import 'package:my_gstore/common/model/product_model.dart';
import 'package:my_gstore/common/navigation/route_names.dart';

import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/common/ultils/format_utils.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/custom_cache_image_network.dart';

import '../../../routes.dart';

class ListViewGShopItem extends StatelessWidget {
  final GShopModels? gshop;

  const ListViewGShopItem({Key? key, this.gshop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Routes.instance
            .navigateTo(RouteName.gShopInformationScreen, arguments: gshop);
      },
      child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  child: Stack(
                    children: [
                      CustomCacheImageNetwork(
                        border: 8,
                        url: gshop?.avartaUrl ?? '',
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                      gshop?.type == 3 ? Positioned(
                        right: 0,
                        top: 0,
                        child: Stack(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomLeft: Radius.circular(12)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                    AppColors.logoSkyBlue.withOpacity(0.9),
                                  ),
                                  width: 30,
                                  height: 25,
                                )),
                            Positioned.fill(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    IconConst.logo,
                                    width: 18,
                                    height: 18,
                                    color: AppColors.white,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ):SizedBox()
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 186,
                      margin: const EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        gshop?.fullname ?? 'User',
                        maxLines: 1,
                        style: AppTextTheme.normalBlack.copyWith(
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 186,
                      margin: const EdgeInsets.only(left: 16),
                      child: Text(
                          gshop?.address ?? '',
                          maxLines: 2,
                          style: AppTextTheme.normalGrey
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 4,
                          ),
                          Icon(
                            Icons.star,
                            color: AppColors.colorSun,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text("${gshop?.avgRating ?? 0}(${gshop?.ratings ??
                              0})",
                              style: AppTextTheme.smallYellow),
                          const SizedBox(
                            width: 16,
                          ),
                          Image.asset(
                            IconConst.icondistance,
                            width: 18,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text("${(gshop?.km ?? 0).toStringAsFixed(1)}km",
                              style: AppTextTheme.smallGreen),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                )
              ],
            ),
          )),
    );
    ;
  }
}
