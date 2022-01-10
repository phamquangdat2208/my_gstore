import 'package:flutter/material.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';

import '../../presentation/routes.dart';

class MyAppBar extends StatefulWidget {
  String title;

  MyAppBar({Key? key, required this.title}) : super(key: key);

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
      title: Text(
        widget.title,
        style: AppTextTheme.mediumBlack,
      ),
      leading: IconButton(
        onPressed: () {
          Routes.instance.pop();
        },
        icon: const Icon(
          Icons.keyboard_arrow_left,
          color: AppColors.black,
        ),
      ),
    );
  }
}
