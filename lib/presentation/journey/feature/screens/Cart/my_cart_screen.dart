import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';

import 'order_screen.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  int value = 1;
  var list = ItemCart.listCart;
  int giaTien = 0;

  @override
  void initState() {
    tinhGiaTien();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, index) {
              return Container(
                padding:
                    EdgeInsets.only(right: 4, left: 16.0, bottom: 16.0, top: 4),
                margin: EdgeInsets.only(bottom: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.grey4),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Spacer(),
                        Image.asset(
                          'assets/icons/close-button.png',
                          width: 14,
                          height: 14,
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 122,
                          height: 122,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(list[index].pathImage),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 212.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      list[index].name,
                                      style: AppTextTheme.normalRoboto,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      list[index].nameShop,
                                      style: AppTextTheme.smallGrey,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${list[index].price} đ",
                                          style: AppTextTheme.normalPink,
                                        ),
                                        Text(
                                          'Mua sau',
                                          style: AppTextTheme.smallGrey,
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            child: ClipOval(
                                              child: Container(
                                                color: AppColors.grey4,
                                                width: 24,
                                                height: 24,
                                                child: const Icon(
                                                  Icons.remove,
                                                  color: Colors.black,
                                                  size: 20.0,
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                value = list[index].getSL;
                                                if (value > 1) {
                                                  giaTien = 0;
                                                  list[index].setSl = value - 1;
                                                  tinhGiaTien();
                                                } else if (value == 1) {
                                                  return;
                                                }

                                                //listCart[index].sl = listCart[index].sl+1;
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          ClipOval(
                                            child: Container(
                                              alignment: Alignment.center,
                                              color: AppColors.grey4,
                                              width: 24,
                                              height: 24,
                                              child: Text("${list[index].sl}",
                                                  style: AppTextTheme
                                                      .normalRoboto),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          GestureDetector(
                                            child: ClipOval(
                                              child: Container(
                                                color: AppColors.grey4,
                                                width: 24,
                                                height: 24,
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.black,
                                                  size: 20.0,
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                value = list[index].getSL;
                                                list[index].setSl = value + 1;
                                                tinhGiaTien();
                                              });
                                            },
                                          )
                                        ],
                                      ),
                                      ClipOval(
                                        child: Container(
                                            alignment: Alignment.center,
                                            color: AppColors.grey4,
                                            width: 24,
                                            height: 24,
                                            child: const Icon(
                                              Icons.design_services,
                                              color: AppColors.blue,
                                              size: 20.0,
                                            )),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OrderScreen()),
          );
        },
        child: Container(
          height: 48,
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          margin: EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
              color: AppColors.logoGreen,
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${giaTien} đ",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              Row(
                children: [
                  Text("Đặt hàng (${list.length})",
                      style: AppTextTheme.normalWhite),
                  SizedBox(
                    width: 8.0,
                  ),
                  ClipOval(
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.white,
                      width: 24,
                      height: 24,
                      child: Icon(Icons.keyboard_arrow_right,
                          color: AppColors.logoGreen),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void tinhGiaTien() {
    for (int i = 0; i < list.length; i++) {
      int a = (int.parse(list[i].price)) * list[i].sl;
      giaTien += a;
    }
  }
}

class ItemCart {
  String name, nameShop, price, pathImage;
  int sl;

  ItemCart(
      {required this.name,
      required this.nameShop,
      required this.price,
      required this.pathImage,
      required this.sl});

  get getSL {
    return sl;
  }

  set setSl(int slNew) {
    sl = slNew;
  }

  static final List<ItemCart> listCart = [
    ItemCart(
        name: "MV912 / MV932 - Macbook Pro 15 inch 2019 - i9 2.3/16GB",
        nameShop: "Cung cấp bởi máy tính Huy Hoàng",
        price: "54000000",
        pathImage: "assets/images/product.png",
        sl: 1),
    ItemCart(
        name: "MV912 / MV932 - Macbook Pro 15 inch 2019 - i9 2.3/16GB",
        nameShop: "Cung cấp bởi máy tính Huy Hoàng",
        price: "54000000",
        pathImage: "assets/images/product.png",
        sl: 1),
    ItemCart(
        name: "Áo đũi nam cộc tay cổ bẻ hai túi ngực",
        nameShop: "Cung cấp bởi máy tính Huy Hoàng",
        price: "2000000",
        pathImage: "assets/images/product.png",
        sl: 1),
  ];
}
