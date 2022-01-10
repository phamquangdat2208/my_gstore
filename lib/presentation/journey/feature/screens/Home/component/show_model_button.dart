import 'package:flutter/material.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';

class ShowModelButton extends StatefulWidget {
  const ShowModelButton({Key? key}) : super(key: key);

  @override
  _ShowModelButtonState createState() => _ShowModelButtonState();
}

class _ShowModelButtonState extends State<ShowModelButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text(
        '...',
        style: AppTextTheme.medium20PxBlack,
      ),
      onTap: () {
        showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
            ),
            backgroundColor: Colors.white,
            isScrollControlled: true,
            isDismissible: true,
            builder: (BuildContext context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppBar(
                    title: Text(
                      'Tác vụ',
                      style: AppTextTheme.mediumBlack,
                    ),
                    shadowColor: Colors.transparent,
                    backgroundColor: Colors.white,
                    centerTitle: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                      ),
                    ),
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.clear,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            height: 48.0,
                            decoration: BoxDecoration(
                              color: AppColors.grey3,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.touch_app),
                                Text(' Mua ngay')
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          height: 48.0,
                          decoration: BoxDecoration(
                            color: AppColors.grey3,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.add_shopping_cart),
                              Text(' Thêm vào giỏ hàng')
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          height: 48.0,
                          decoration: BoxDecoration(
                            color: AppColors.grey3,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.favorite_outline_rounded),
                              Text(' Thêm vào yêu thích')
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            });
      },
    );
  }
}
