import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/common/ultils/format_utils.dart';

import 'item_pro.dart';


class ListItemNear extends StatefulWidget {
  const ListItemNear({Key? key}) : super(key: key);

  @override
  _ListItemNearState createState() => _ListItemNearState();
}

class _ListItemNearState extends State<ListItemNear> {
  var listItem = ItemProduct.listItemProduct;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildlist(listItem),
    );
  }

  Widget _buildlist(List<ItemProduct> list) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 5,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return _itemWidget(list[index]);
        });
  }

  Widget _itemWidget(ItemProduct model) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.all(8),
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey5,
            blurRadius: 6,
            offset: Offset(1, 1), // Shadow position
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 1 / 3.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  child: Image.asset(model.pathImage),
                ),
              ),
            ],
          ),
          Container(
              padding: EdgeInsets.only(left: 15),
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 1 / 1.8,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text(model.name),
              Container(
                child: Row(
                  children: [
                    Icon(Icons.star, color: AppColors.colorSun,),
                    Text(model.rating.toString(),
                      style: TextStyle(color: AppColors.grey8),),
                    Text('(${model.numberOfReviews.toString()})',
                        style: TextStyle(color: AppColors.grey8)),
                    SizedBox(width: 20,),
                    SvgPicture.asset(IconConst.iconClock),
                    Text(' ${model.km.toString()}km',
                        style: TextStyle(color: AppColors.grey8)),
                  ],
                ),
              ),
              Container(
                  child: Row(
                      children: [
                  Text(FormatUtils.formatCurrencyDoubleToString(model?.price),
                  style: AppTextTheme.normalRobotoRed),
          Spacer(),
          GestureDetector(onTap: () {},
            child: Icon(Icons.more_horiz),)
        ],
      ),
    )],
    ),
    ),
    ],
    ),
    );
  }
}
