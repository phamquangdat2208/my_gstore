import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/common/navigation/route_names.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';

import '../../../../../routes.dart';


class NotificationLayoutTop extends StatefulWidget {
  @override
  _NotificationLayoutTopState createState() => _NotificationLayoutTopState();
}

class _NotificationLayoutTopState extends State<NotificationLayoutTop> {
  void _onNewsTap() {
    // Routes.instance.navigateTo(RouteName.newsScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          InkWell(
            onTap: _onNewsTap,
            child: _itemWidget(),
          ),
          const Divider(color: AppColors.grey5, height: 1),
        ],
      ),
    );
  }

  Widget _itemWidget() => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        const SizedBox(width: 12),
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.grey4, width: 2),
          ),
          padding: const EdgeInsets.all(10),
          child: SvgPicture.asset(
            IconConst.iconNews,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Tin Tức',
                  style: AppTextTheme.normalGrey9.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 4),
                Text('Thường xuyên cập nhập tin tức để sắn các mã giảm giá trực tiếp vào sản phẩm bạn nhé!',
                    style: AppTextTheme.normalGrey9),
              ],
            )),
      ],
    ),
  );
}
