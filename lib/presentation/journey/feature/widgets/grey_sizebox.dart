import 'package:flutter/material.dart';
import 'package:my_gstore/common/theme/theme_color.dart';

class GreySizedBox extends StatelessWidget {
  final double? height;
  const GreySizedBox({Key? key,this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: AppColors.grey3, width: double.infinity, height: height??8);
  }
}
