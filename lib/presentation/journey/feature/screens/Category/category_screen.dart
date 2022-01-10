import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_gstore/common/customs/custom_scaffold.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [

                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    decoration: BoxDecoration(
                      color: AppColors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 7.0,
                  alignment: WrapAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 84.0,
                        height: 102.0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              '',
                              width: 40.0,
                              height: 40.0,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Xã Hội',
                              textAlign: TextAlign.center,
                              style: AppTextTheme.normalGrey9,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _itemCategory() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 84.0,
        height: 102.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              '',
              width: 40.0,
              height: 40.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              '',
              textAlign: TextAlign.center,
              style: AppTextTheme.normalGrey9,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
