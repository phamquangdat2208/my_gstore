

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/common/theme/theme_color.dart';

class HomeCenter extends StatelessWidget {
  const HomeCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 16, bottom: 10),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                getListItemV1(),
              ],
            ),
          ),

          Container(
            height: 65,
            color: Colors.white,
            margin: const EdgeInsets.only(left: 10, right: 10),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(8.0)),
                      border: Border.all(color: AppColors.green)),
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Row(
                    children: [
                      Image.asset(
                        IconConst.logo,
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          AutoSizeText(
                            "G-FAMILY FOUNDATION",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                            maxLines: 1,
                            minFontSize: 8,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text("176.544,000đ",
                              style: TextStyle(
                                  color: AppColors.fashion,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500)),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Container(
                  height: 65,
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.colorSun),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(8.0))),
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Điểm cống hiến lan tỏa",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize:8,
                            fontWeight: FontWeight.w700),
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                IconConst.homecenter_hand,
                                width: 20,
                                height: 15,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              const Text("99.443.600",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 8,
                                      color: AppColors.grey8))
                            ],
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            height: 20,
                            width: 1,
                            color: Colors.black12,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                IconConst.homecenter_chart,
                                width: 20,
                                height: 15,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              const Text(
                                "0,5564%",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 8,
                                    color: AppColors.grey8),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  getListItemV1() {
    List<Widget> listW = [];
    for (int i = 0; i < ItemV1Model.listV1.length; i++) {
      listW.add(itemV1(ItemV1Model.listV1[i]));
    }
    return Row(
      children: listW,
    );
  }

  Widget itemV1(ItemV1Model v1model) {
    return ItemV1(
      pathImage: v1model.path,
      string1: v1model.string1,
      string2: v1model.string2,
      onTab: () {},
    );
  }
}
class ItemV1 extends StatefulWidget {
  String pathImage;
  String string1;
  String string2;
  Function onTab;
  ItemV1(
      {Key? key,
        required this.pathImage,
        required this.string1,
        required this.string2,
        required this.onTab})
      : super(key: key);

  @override
  ItemV1State createState() => ItemV1State();
}

class ItemV1State extends State<ItemV1> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 75,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.deepOrange),
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(8.0))
        ),
        margin: const EdgeInsets.only(left: 10),
        padding: const EdgeInsets.all(10.0),
        width: (MediaQuery.of(context).size.width - 60) / 5,
        child: Column(
          children: [
            Image.asset(
              widget.pathImage,
              width: MediaQuery.of(context).size.width * 0.07,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.string1,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 8),
            ),
            Text(widget.string2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 8)),
          ],
        ),
      ),
      onTap: () {
        widget.onTab;
      },
    );
  }
}
class ItemV1Model {
  String path, string1, string2;

  ItemV1Model(
      {required this.path, required this.string1, required this.string2});

  static final List<ItemV1Model> listV1 = [
    ItemV1Model(path: IconConst.homecenter_qr, string1: "Mã QR", string2: "Giới thiệu"),
    ItemV1Model(path: IconConst.homecenter_gshop, string1: "G-Shop", string2: "Cửa hàng đa năng"),
    ItemV1Model(path: IconConst.homecenter_share, string1: "Chia sẻ", string2: "Đồ ăn"),
    ItemV1Model(path: IconConst.homecenter_gift, string1: "Cho tặng", string2: "Đồ cũ"),
    ItemV1Model(path: IconConst.homecenter_edu, string1: "Giáo dục", string2: "Trực tuyến"),
  ];
}

