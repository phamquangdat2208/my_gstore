import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/common/model/gshop_model.dart';
import 'package:my_gstore/common/navigation/route_names.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/common/ultils/format_utils.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/custom_cache_image_network.dart';

import '../../../../routes.dart';

class CategoryDetailWidgetItemGShop extends StatelessWidget {
  final double itemWidth;
  final GShopModels? information;

  const CategoryDetailWidgetItemGShop({
    Key? key,
    required this.itemWidth,
    this.information,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Routes.instance
            .navigateTo(RouteName.gShopInformationScreen, arguments: information);
      },
      child: Container(
        width: itemWidth,
        decoration: BoxDecoration(
          color: AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:EdgeInsets.all(2),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                gradient: LinearGradient(
                  colors: AppColors.colorsGradient,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Stack(
                children: [
                  CustomCacheImageNetwork(
                    url: information?.avartaUrl??'',
                    width: double.infinity,
                    height: 146,
                    fit: BoxFit.cover,
                    border: 12,
                  ),
                  information?.type == 3 ? Positioned(
                    right: 0,
                    top: 0,
                    child: Stack(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12),
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
                                IconConst.homecenter_gshop,
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
              ),),
            SizedBox(height: 4.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height:20,
                    child: Text(
                      information?.fullname ?? 'User',
                      overflow: TextOverflow.ellipsis,
                      style: AppTextTheme.mediumBlack.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    information?.address ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: AppTextTheme.normalGrey,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                  ),
                  Divider(height: 8,color: AppColors.grey6,),
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: 1,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 1,
                        itemSize: 10.0,
                        direction: Axis.horizontal,
                      ),
                      Text(
                        ' ${information?.avgRating??0}',
                        style: AppTextTheme.smallYellow,
                      ),
                      Text(
                        '(${information?.ratings??0})',
                        style: AppTextTheme.smallYellow,
                      ),

                      SizedBox(width: 24,),
                      Image.asset(
                        IconConst.icondistance,
                        width: 18,
                      ),
                      Text(
                        ' ${(information?.km??0).toStringAsFixed(1)}km',
                        style: AppTextTheme.smallGreen,
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
