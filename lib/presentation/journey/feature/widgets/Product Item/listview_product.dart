import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/common/constants/string_const.dart';
import 'package:my_gstore/common/customs/custom_gesturedetactor.dart';
import 'package:my_gstore/common/model/product_model.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/common/ultils/screen_utils.dart';

import 'gridview_product_item.dart';

class ListViewDisplayProduct extends StatelessWidget {
  final int numberItem;
  final String label;
  final bool haveIcon;
  final List<ProductModel>? productModel;
  final bool notExpand;
  final Function? onMore;

  const ListViewDisplayProduct({
    Key? key,
    this.numberItem = 2,
    required this.label,
    this.productModel,
    this.notExpand = false,
    this.haveIcon = true,
    this.onMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (productModel?.isEmpty ?? true) {
      return SizedBox();
    }
    final _itemWidth = (GScreenUtil.screenWidthDp - 48)/2;
    final _itemHeight = _itemWidth + 60;
    return Column(
      children: [
        SizedBox(height: 16),
        Row(
          children: [
            haveIcon
                ? Row(
              children: [
                const SizedBox(width: 12),
                Image.asset(
                  IconConst.homecenter_gshop,
                  width: 19,
                  height: 27,
                ),
              ],
            )
                : const SizedBox(width: 8),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTextTheme.mediumBlack.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            CustomGestureDetector(
              onTap: () {
                if (onMore != null) {
                  onMore!();
                }
                ;
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  StringConst.all,
                  style: AppTextTheme.normalBlue,
                ),
              ),
            )
          ],
        ),
        Container(
          height: _itemHeight+40,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount:
            notExpand ? min(productModel?.length ?? 0, 4) : productModel?.length,
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            itemBuilder: (context, index){
              return Padding(
                padding: EdgeInsets.only(left: 8,right: 8),
                child: CategoryDetailWidgetItemProduct(
                  itemWidth: _itemWidth,
                  productModel: productModel?[index],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
