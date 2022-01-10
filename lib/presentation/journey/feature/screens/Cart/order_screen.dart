import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/button_component_icon.dart';
import 'my_cart_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int giatien = 0;
  var listItemCart = ItemCart.listCart;

  @override
  void initState() {
    tinhGiaTien();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        centerTitle: true,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black45,
          ),
        ),
        title:
            const Text("Thông tin đơn hàng", style: AppTextTheme.mediumBlack),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 10.0),
              padding: EdgeInsets.all(20.0),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Colors.white,
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/icons/address.png",
                          width: 22,
                          height: 27,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Giao hàng đến",
                                  style: AppTextTheme.smallBlack),
                              Text("Ngõ 259, Số 43 Yên Hòa, Cầu Giấy, Hà Nội",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: AppTextTheme.normalRoboto),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        /////go to choose address
                      },
                      child: Text("Thay đổi", style: AppTextTheme.normalBlue))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(20.0),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: Colors.white,
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/icons/pay.png",
                          width: 22,
                          height: 27,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Hình thức thanh toán",
                                style: AppTextTheme.smallGrey),
                            Text("Tiền mặt", style: AppTextTheme.normalRoboto),
                          ],
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        // go to choose payment
                      },
                      child: Text("Thay đổi", style: AppTextTheme.normalBlue))
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20.0, bottom: 10.0, left: 20.0),
              child: Text("SỐ LƯỢNG SẢN PHẨM", style: AppTextTheme.normalGrey),
            ),
            Container(child: _buildList(ItemCart.listCart)),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(20.0),
              color: Colors.white,
              child: Row(
                children: [
                  Text("Tiền sản phẩm", style: AppTextTheme.normalRoboto),
                  Expanded(
                    child: Container(),
                  ),
                  Text("${giatien} đ", style: AppTextTheme.normalGrey)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              color: Colors.white,
              child: Row(
                children: [
                  Text("Tiền ship", style: AppTextTheme.normalRoboto),
                  Expanded(
                    child: Container(),
                  ),
                  Text("Miễn phí ship", style: AppTextTheme.normalGrey)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              color: Colors.white,
              child: Row(
                children: [
                  Text("Thời gian nhận hàng", style: AppTextTheme.normalRoboto),
                  Expanded(
                    child: Container(),
                  ),
                  Text("Giờ hành chính", style: AppTextTheme.normalGrey)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(20.0),
              color: Colors.white,
              child: Row(
                children: [
                  Text("Coupon", style: AppTextTheme.normalRoboto),
                  Expanded(
                    child: Container(),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.grey7,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20.0),
        height: MediaQuery.of(context).size.height * 1.7 / 10,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.grey6.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 8,
              offset: Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Text("Tổng tiền", style: AppTextTheme.normalGrey8),
                Expanded(child: Container()),
                Text("${giatien} đ", style: AppTextTheme.mediumPink)
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            ButtonWidget(
                onPressed: () {
                  //goto order screen
                },
                buttonTitle: 'Đặt hàng',
                backGrButton: AppColors.logoGreen)
          ],
        ),
      ),
    );
  }

  Widget _buildList(List<ItemCart> _listCart) {
    List<Widget> _widgets = [];
    for (var index = 0; index < _listCart.length; index++) {
      _widgets.add(_itemWidget(_listCart[index]));
    }
    return Column(
      children: _widgets,
    );
  }

  Widget _itemWidget(ItemCart itemCart) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
            color: AppColors.grey4,
          ))),
      child: Row(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 40,
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Image.asset(
                        itemCart.pathImage,
                        width: 32,
                        height: 32,
                      ),
                    ),
                    SizedBox(
                      width: 6.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.76,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(itemCart.name,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextTheme.normalRoboto),
                          SizedBox(
                            height: 6.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${itemCart.price} đ",
                                  style: AppTextTheme.normalPink),
                              Text(itemCart.sl.toString(),
                                  style: AppTextTheme.normalGrey)
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void tinhGiaTien() {
    for (int i = 0; i < listItemCart.length; i++) {
      int a = (int.parse(listItemCart[i].price)) * listItemCart[i].sl;
      giatien += a;
      // print("${listItemCart[i].price}");
    }
  }
}
