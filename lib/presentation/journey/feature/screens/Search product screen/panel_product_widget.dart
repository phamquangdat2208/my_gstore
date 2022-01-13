import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/common/customs/custom_gesturedetactor.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'item_pro.dart';

class ProductPanel extends StatelessWidget {
  final ScrollController controller;
  final PanelController panelController;

  ProductPanel(
      {Key? key, required this.controller, required this.panelController})
      : super(key: key);
  var listItem = ItemProduct.listItemProduct;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
          decoration: const BoxDecoration(
              color: AppColors.grey3,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: _BuildGridView(listItem)),
    );
  }

  void toggleClose() {
    print('--------------------------close-------------------');
    panelController.isPanelClosed
        ? panelController.open()
        : panelController.close();
  }

  void toggleOpen() {
    panelController.isPanelOpen
        ? panelController.close()
        : panelController.open();
  }

  Widget _BuildGridView(List<ItemProduct> list) {
    // return Container(width: 40,height: 50,color: Colors.green,);
    return Column(
      children: [
        Row(
          children: [
            CustomGestureDetector(
              onTap: toggleClose,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Icon(Icons.close),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 40),
              child: GestureDetector(
                  onTap: toggleOpen,
                  child: Icon(
                    Icons.keyboard_arrow_up,
                    size: 35,
                  )),
            ),
            Spacer(),
          ],
        ),

      ],
    );
  }
}
