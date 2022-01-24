import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_gstore/common/model/gshop_model.dart';
import 'package:my_gstore/common/ultils/screen_utils.dart';
import 'package:my_gstore/presentation/journey/feature/screens/gshop%20map%20screen/widget/ghop_map_screen_item.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/G%20Shop%20Items/listview_gshop_item.dart';

class ListViewDisplayGShopMapScreen extends StatelessWidget {
  final int numberItem;
  final List<GShopModels>? information;
  final bool notExpand;
  final Function? onMore;

  final ScrollController? scrollController;
  const ListViewDisplayGShopMapScreen({
    Key? key,
    this.numberItem = 2,
    this.information,
    this.notExpand = false,
    this.onMore,
    this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (information?.isEmpty ?? true) {
      return SizedBox();
    }
    final _itemWidth = (GScreenUtil.screenWidthDp - 54)/2;
    final _itemHeight = _itemWidth + 60;
    return Column(
      children: [
        SizedBox(height: 16),
        Container(
          color: Colors.transparent,
          height: _itemHeight+34,
          width: double.infinity,
          child: ListView.builder(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            itemCount:
            notExpand ? min(information?.length ?? 0, 4) : information?.length,
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            itemBuilder: (context, index){
              return Padding(
                padding: EdgeInsets.only(left: 8,right: 8),
                child: MapSearchScreenItem(
                  itemWidth: _itemWidth,
                  information: information?[index],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
