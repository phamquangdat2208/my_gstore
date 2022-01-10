import 'package:flutter/material.dart';
import 'package:my_gstore/common/theme/theme_color.dart';

class CustomRefreshIndicator extends StatelessWidget {
  final Widget child;
  final RefreshCallback onRefresh;

  const CustomRefreshIndicator(
      {Key? key, required this.onRefresh, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: child,
      backgroundColor: Colors.white,
      color: AppColors.primaryColor,
      onRefresh: onRefresh,
    );
  }
}
