import 'package:flutter/material.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/ultils/screen_utils.dart';
import 'package:shimmer/shimmer.dart';

class CategoryDetailShimmerTab extends StatelessWidget {
  final double? height;

  const CategoryDetailShimmerTab({Key? key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _itemWidth = (GScreenUtil.screenWidthDp - 48) / 2;
    final _itemHeight = _itemWidth + 110;
    return Container(
      width: double.infinity,
      height:height?? double.infinity,
      child: Shimmer.fromColors(
        baseColor: AppColors.grey300,
        highlightColor: AppColors.grey100,
        enabled: true,
        child: GridView.builder(
          itemCount: 10,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          gridDelegate:
          // ignore: lines_longer_than_80_chars
          SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: _itemWidth / _itemHeight,
          ),
          itemBuilder: (context, index) {
            return Container(
              width: _itemWidth,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: Padding(
                padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            width: double.infinity,
                            height: _itemWidth,
                            color: AppColors.white,
                          ),
                        ),
                        Positioned(
                          bottom: 8.0,
                          right: 8.0,
                          child: Container(
                            width: 32.0,
                            height: 32.0,
                            color: AppColors.white,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 4.0),
                    Container(
                      width: double.infinity,
                      height: 43.0,
                      color: AppColors.white,
                    ),
                    SizedBox(height: 4.0),
                    Row(
                      children: [
                        SizedBox(width: 1.5),
                        Container(
                          width: 16.0,
                          height: 16.0,
                          color: AppColors.white,
                        ),
                        SizedBox(width: 5.38),
                        Container(
                          color: AppColors.white,
                          width: 20.0,
                          height: 14.0,
                        ),
                        SizedBox(width: 17.0),
                        Container(
                          color: AppColors.white,
                          width: 14.0,
                          height: 14.0,
                        ),
                        SizedBox(width: 5.0),
                        Container(
                          color: AppColors.white,
                          width: 20.0,
                          height: 14.0,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Divider(
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Container(
                          color: AppColors.white,
                          width: 100.0,
                          height: 14.0,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
