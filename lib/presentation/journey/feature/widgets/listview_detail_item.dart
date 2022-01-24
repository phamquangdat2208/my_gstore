import 'package:flutter/material.dart';
import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/common/model/product_model.dart';
import 'package:my_gstore/common/navigation/route_names.dart';

import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/common/ultils/format_utils.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/custom_cache_image_network.dart';

import '../../../routes.dart';

class ListViewDetailItem extends StatelessWidget {
  final ProductModel? products;

  const ListViewDetailItem({Key? key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Routes.instance
            .navigateTo(RouteName.detailProductScreen, arguments: products);
      },
      child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          width: MediaQuery.of(context).size.width,
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
                        url: products?.urlPicture ?? '',
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                      products?.percentDiscount != 0
                          ? Positioned(
                              right: 0,
                              top: 0,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(2)),
                                    child: Image.asset(
                                      IconConst.discountPercent,
                                      width: 36,
                                      height: 36,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${products?.percentDiscount ?? 0}%',
                                          style: AppTextTheme.normalRobotoRed,
                                          textScaleFactor: 1,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            'GIẢM',
                                            style: AppTextTheme
                                                .normalRobotoWhite
                                                .copyWith(
                                              fontSize: 8,
                                            ),
                                            textScaleFactor: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 186,
                      margin: const EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        products?.name ?? '',
                        maxLines: 2,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 16),
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
                          Text("${products?.avgRating}(${products?.ratings})",
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.grey8)),
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
                          Text("${(products?.kmText)}km",
                              style:AppTextTheme.smallGreen),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Divider(
                      height: 1,
                      color: AppColors.grey2,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 16),
                      width: MediaQuery.of(context).size.width - 186,
                      child: Row(
                        children: [
                          Text(
                              FormatUtils.formatCurrencyDoubleToString(
                                  products?.priceOld ?? 0),
                              style: AppTextTheme.smallGrey.copyWith(decoration: TextDecoration.lineThrough,fontSize: 10)),
                          SizedBox(width: 2),
                          Text(
                              FormatUtils.formatCurrencyDoubleToString(
                                  products?.priceNew ?? 0),
                              style: AppTextTheme.normalRobotoRed),
                          Expanded(child: Container()),
                          const Icon(
                            Icons.more_horiz,
                            color: Colors.black45,
                          )
                        ],
                      ),
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
