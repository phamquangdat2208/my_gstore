import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_gstore/common/model/product_model.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/common/ultils/common_util.dart';
import 'package:my_gstore/common/ultils/screen_utils.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/Product%20Item/gridview_product_item.dart';


class GridViewDisplayProductMapSearch extends StatelessWidget {
  final int numberItem;
  final String label;
  final bool haveIcon;
  final List<ProductModel>? courses;
  final bool notExpand;

  const GridViewDisplayProductMapSearch({
    Key? key,
    this.numberItem =2,
    required this.label,
    this.courses,
    this.notExpand = false,
    this.haveIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (courses?.isEmpty ?? true) {
      return SizedBox();
    }
    final _itemWidth = (GScreenUtil.screenWidthDp - 48) / 2;
    final _itemHeight = _itemWidth + 70;
    final numberRow = CommonUtils.countNumberRowOfGridview(courses);
    final heightList =
        (notExpand ? min(numberRow, 2) : numberRow) * (_itemHeight + 25);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: AppColors.white,
          width: double.infinity,
          height: heightList,
          child: GridView.builder(
            itemCount:
            notExpand ? min(courses?.length ?? 0, 4) : courses?.length,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: numberItem,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 12.0,
              childAspectRatio: _itemWidth / _itemHeight,
            ),
            itemBuilder: (context, index) {
              return CategoryDetailWidgetItemProduct(
                itemWidth: _itemWidth,
                productModel: courses?[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
