import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/common/model/product_model.dart';
import 'package:my_gstore/common/navigation/route_names.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/common/ultils/format_utils.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/custom_cache_image_network.dart';

import '../../../../routes.dart';

class CategoryDetailWidgetItemProduct extends StatelessWidget {
  final double itemWidth;
  final ProductModel? productModel;

  const CategoryDetailWidgetItemProduct({
    Key? key,
    required this.itemWidth,
    this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Routes.instance
            .navigateTo(RouteName.detailProductScreen, arguments: productModel);
      },
      child: Container(
        width: itemWidth,
        decoration: BoxDecoration(
          color: AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    gradient: LinearGradient(
                      colors: AppColors.colorsGradient,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: CustomCacheImageNetwork(
                    url: productModel?.urlPicture ?? '',
                    width: double.infinity,
                    height: 146,
                    fit: BoxFit.cover,
                    border: 8,
                  ),
                ),
                productModel?.percentDiscount != 0
                    ? Positioned(
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
                                  width: 80,
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
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    'Gi???m',
                                    style:
                                        AppTextTheme.normalRobotoWhite.copyWith(
                                      fontSize: 10,
                                    ),
                                    textScaleFactor: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 2, left: 2),
                                    child: Text(
                                      '${productModel?.percentDiscount}%',
                                      style: AppTextTheme.normalRobotoWhite,
                                      textScaleFactor: 1,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    : Positioned(
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
                      )
              ],
            ),
            SizedBox(height: 4.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 35,
                    child: Text(
                      productModel?.name ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: AppTextTheme.normalBlack.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(height: 4),
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
                        ' ${productModel?.avgRating ?? 0}',
                        style: AppTextTheme.smallYellow,
                      ),
                      Text(
                        '(${productModel?.ratings ?? 0})',
                        style: AppTextTheme.smallYellow,
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      Image.asset(
                        IconConst.icondistance,
                        width: 18,
                      ),
                      Text(
                        ' ${(productModel?.kmText)}km',
                        style: AppTextTheme.smallGreen,
                      ),
                    ],
                  ),
                  Divider(
                    height: 8,
                    color: AppColors.grey6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                          '${FormatUtils.formatCurrencyDoubleToString(productModel?.priceOld ?? 0)}',
                          style: AppTextTheme.smallgreyline.copyWith(
                              decoration: TextDecoration.lineThrough)),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        '${FormatUtils.formatCurrencyDoubleToString(productModel?.priceNew ?? 0000)}',
                        style: AppTextTheme.normalRobotoRed,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
