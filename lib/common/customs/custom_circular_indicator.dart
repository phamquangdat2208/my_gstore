import 'package:flutter/material.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
class CustomCircularIndicator extends StatelessWidget {
  const CustomCircularIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircularProgressIndicator(
              color: AppColors.grey7,
            ),
          ),
        ],
      ),
    );;
  }
}
