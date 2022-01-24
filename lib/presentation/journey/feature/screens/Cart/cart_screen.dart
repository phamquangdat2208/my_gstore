import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:my_gstore/common/component/updating.dart';
import 'package:my_gstore/common/constants/gif_constant.dart';
import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/common/constants/image_constant.dart';
import 'package:my_gstore/common/customs/custom_scaffold.dart';
import 'package:my_gstore/common/network/app_client.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/presentation/injector_container.dart';
import 'package:my_gstore/presentation/journey/feature/screens/Cart/buy_later_screen.dart';
import 'package:my_gstore/presentation/journey/feature/screens/Cart/favourite_cart_screen.dart';

import 'my_cart_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: CustomScaffold(
          customAppBar: PreferredSize(
            preferredSize: Size.fromHeight(270.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 138.0,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 91.0),
                      decoration: BoxDecoration(),
                    ),
                    Container(
                      height: 150,
                      width: double.infinity,
                      child: Image.asset(
                        ImageConstant.mockTopBackGround,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Positioned(
                      top: 100,
                      left: MediaQuery.of(context).size.width -
                          (MediaQuery.of(context).size.width - 30),
                      child: Container(
                          height: 108.0,
                          width: MediaQuery.of(context).size.width - 60,
                          child: Container(
                            padding: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.grey7,
                                  blurRadius: 6,
                                  offset: Offset(1, 1), // Shadow position
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  child: LottieBuilder.asset(
                                    GifConst.selectAddress,
                                    repeat: false,
                                  ),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Giao hàng đến',
                                      style: AppTextTheme.normalRoboto,
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${injector<AppClient>().globalAppCatch.profileModel?.address??''}',
                                        style: AppTextTheme.normalGrey,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: const Text(
                                        'Thay đổi',
                                        style: AppTextTheme.normalBlue,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
                Container(
                  child: TabBar(
                    labelColor: AppColors.greenText,
                    labelPadding: EdgeInsets.only(
                        bottom: 10.0, right: 20.0, left: 20.0),
                    unselectedLabelColor: AppColors.grey7,
                    indicatorColor: AppColors.greenText,
                    tabs: [
                      Text('Giỏ hàng'),
                      Text('Yêu thích'),
                      Text('Mua sau'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              MyCart(),
              FavouriteCartScreen(),
              BuyLaterScreen(),
            ],
          )),
    );
  }
}
