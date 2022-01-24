import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_gstore/common/constants/string_const.dart';
import 'package:my_gstore/common/customs/custom_gesturedetactor.dart';
import 'package:my_gstore/common/model/gshop_model.dart';
import 'package:my_gstore/common/model/product_model.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/common/ultils/common_util.dart';
import 'package:my_gstore/common/ultils/screen_utils.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/listview_detail_item.dart';

import 'listview_gshop_detail_item.dart';

class ListViewDetailGShop extends StatelessWidget {
  final int numberItem;
  final String label;
  final List<GShopModels>? GshopModel;
  final bool notExpand;

  const ListViewDetailGShop({
    Key? key,
    this.numberItem = 2,
    required this.label,
    this.GshopModel,
    this.notExpand = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (GshopModel?.isEmpty ?? true) {
      return SizedBox();
    }
    final _itemWidth = (GScreenUtil.screenWidthDp - 48)/2;
    final _itemHeight = _itemWidth -12;
    final numberRow = CommonUtils.countNumberRowOfGridview(GshopModel);
    final heightList =
        (notExpand ? min(numberRow, 6) : numberRow) * (_itemHeight + 10);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTextTheme.mediumBlack.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: heightList,
          width: double.infinity,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount:
            notExpand ?  GshopModel?.length: min(GshopModel?.length ?? 0,6),
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            itemBuilder: (context, index){
              return Padding(
                padding: EdgeInsets.all(8),
                child: ListViewGShopItem(
                  gshop: GshopModel?[index],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
