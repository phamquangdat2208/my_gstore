import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/common/constants/image_constant.dart';
import 'package:my_gstore/common/constants/personal_constant.dart';
import 'package:my_gstore/common/constants/string_const.dart';
import 'package:my_gstore/common/customs/custom_gesturedetactor.dart';
import 'package:my_gstore/common/navigation/route_names.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/common/ultils/validate_ultil.dart';
import 'package:my_gstore/presentation/journey/feature/auth/individual/String%20Constant/personal_const.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/button_bottom.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/custom_modal_bottom_sheet_image.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/custom_textfield.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/layout_select_image_empty.dart';

import '../../../../routes.dart';

class PostedForSalePage extends StatefulWidget {
  const PostedForSalePage({Key? key}) : super(key: key);

  @override
  _PostedForSalePageState createState() => _PostedForSalePageState();
}

class _PostedForSalePageState extends State<PostedForSalePage> {
  final _formKey = GlobalKey<FormState>();
  final bool bl1 = true;
  final bool bl2 = true;
  bool _isShow = true;

  void _onChangeShow(value) {
    setState(() {
      _isShow = !_isShow;
    });
  }

  bool _isHasShip = true;

  void _onChangeShowHasShip(value) {
    setState(() {
      _isHasShip = !_isHasShip;
    });
  }

  bool _agreePolicy = false;

  void _AgreePolicy(value) {
    setState(() {
      _agreePolicy = !_agreePolicy;
    });
  }

  List<ItemCategory> listItem2 = [
    ItemCategory(id: 1, name: 'Thời trang nam'),
    ItemCategory(id: 2, name: 'Thời trang nữ'),
    ItemCategory(id: 3, name: 'Thời trang trẻ em'),
  ];

  List<ItemDepositPlace> list4 = [
    ItemDepositPlace(
        naneShop: "Phạm Hùng Vân",
        address: "Cách 1.5km - Ngõ 259, Số 43 Yên Hòa, Cầu Giấy, Hà Nội",
        phone: ' 033939388338',
        pathImage: "assets/profile/img_demo_face.png"),
    ItemDepositPlace(
        naneShop: "Phạm Hùng Long",
        address: "Cách 1.5km - Ngõ 259, Số 43 Yên Hòa, Cầu Giấy, Hà Nội",
        phone: ' 033939388338',
        pathImage: "assets/profile/img_demo_face.png"),
    ItemDepositPlace(
        naneShop: "Phạm Hùng Hổ",
        address: "Cách 1.5km - Ngõ 259, Số 43 Yên Hòa, Cầu Giấy, Hà Nội",
        phone: ' 033939388338',
        pathImage: "assets/profile/img_demo_face.png"),
    ItemDepositPlace(
        naneShop: "Phạm Hùng Bá",
        address: "Cách 1.5km - Ngõ 259, Số 43 Yên Hòa, Cầu Giấy, Hà Nội",
        phone: ' 033939388338',
        pathImage: "assets/profile/img_demo_face.png"),
    ItemDepositPlace(
        naneShop: "Phạm Hùng Khánh",
        address: "Cách 1.5km - Ngõ 259, Số 43 Yên Hòa, Cầu Giấy, Hà Nội",
        phone: ' 033939388338',
        pathImage: "assets/profile/img_demo_face.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.grey100,
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            StringConst.newProduct,
            style: AppTextTheme.mediumBlack,
          ),
          leading: TextButton(
            child:
                const Text(StringConst.cancel, style: AppTextTheme.normalBlue),
            onPressed: () {
              Routes.instance.pop();
            },
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomGestureDetector(
                  onTap: (){
                    customModalBottomSheet(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Row(
                      children: [
                        SizedBox(
                            width: 70,
                            height: 70,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                border: Border.all(
                                  color: AppColors.grey5,
                                ),
                              ),
                              child: Icon(
                                Icons.add,
                              ),
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          PersonalConstant.AddProductAvatar,
                          style: AppTextTheme.normalGrey,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  color: AppColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        child: LayoutSelectImageLayoutEmptyImage(
                          onTap: () {
                            customModalBottomSheet(context);
                          },
                          text: StringConst.addImageOrVideo,
                        ),
                      ),
                      Text(
                        StringConst.suggestAddImage,
                        style: AppTextTheme.smallGrey,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                CustomGestureDetector(
                  onTap: (){
                    customModalBottomSheet(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Row(
                      children: [
                        SizedBox(
                            width: 70,
                            height: 70,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                border: Border.all(
                                  color: AppColors.grey5,
                                ),
                              ),
                              child: Icon(
                                Icons.add,
                              ),
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: Text(
                          PersonalConstant.suggestPolicyImage,
                          style: AppTextTheme.normalGrey,
                          maxLines: 3,
                        ))
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 16.0,
                  ),
                  child: Column(
                    children: [
                      CustomTextField(
                        hintText: PersonalConstant.nameProduct,
                        // controller: _productNameController,
                        onValidate: ValidateUtil.validNameProduct,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                      Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            PersonalConstant.suggestNameProduct,
                            style: AppTextTheme.smallGrey,
                          )),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        height: 56,
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Danh mục",
                              style: TextStyle(
                                  color: Colors.black38, fontSize: 14),
                            ),
                            Expanded(child: Container()),
                            const Icon(
                              Icons.arrow_drop_down_rounded,
                              size: 40,
                              color: Colors.black38,
                            )
                          ],
                        ),
                      ), // Danh mục
                      SizedBox(
                        height: 12,
                      ),
                      CustomTextField(
                        textInputType: TextInputType.number,
                        hintText: PersonalConstant.entity,
                        // controller: _productNameController,
                        // onValidate: ValidateUtil.validNameProduct,
                        textCapitalization: TextCapitalization.sentences,
                      ), // số lượng
                      SizedBox(
                        height: 12,
                      ),

                      CustomTextField(
                        hintText: PersonalConstant.option,
                        // controller: _productNameController,
                        // onValidate: ValidateUtil.validNameProduct,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      GestureDetector(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          height: 56,
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                "Điểm bán",
                                style: TextStyle(
                                    color: Colors.black38, fontSize: 14),
                              ),
                              Expanded(child: Container()),
                              const Icon(
                                Icons.arrow_drop_down_rounded,
                                size: 40,
                                color: Colors.black38,
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          customModalBottomSheet5(
                              context, 0.9, (indexx) => null);
                        },
                      ), //   điểm bán
                      SizedBox(
                        height: 12,
                      ),
                      CustomTextField(
                        suffixIcon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('VND',style: AppTextTheme.normalBlack,),
                          ],
                        ),
                        textInputType: TextInputType.number,
                        hintText: PersonalConstant.price,
                        // controller: _productNameController,
                        // onValidate: ValidateUtil.validNameProduct,
                        textCapitalization: TextCapitalization.sentences,
                      ), // mô tả
                      // giá sản phẩm

                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Transform.scale(
                            scale: 0.7,
                            origin: const Offset(-30, 0),
                            child: CupertinoSwitch(
                              onChanged: _onChangeShowHasShip,
                              value: _isHasShip,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text("Cung cấp dịch vụ vận chuyển hàng")
                        ],
                      ),
                      Row(
                        children: [
                          Transform.scale(
                            scale: 0.7,
                            origin: const Offset(-30, 0),
                            child: CupertinoSwitch(
                              onChanged: _onChangeShow,
                              value: _isShow,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text("Hiện sản phẩm")
                        ],
                      ),
                      Row(
                        children: [
                          Transform.scale(
                            scale: 0.7,
                            origin: const Offset(-30, 0),
                            child: CupertinoSwitch(
                              onChanged: _AgreePolicy,
                              value: _agreePolicy,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text:
                                          'Bạn đồng ý với chính sách đăng bán của G-Store ',
                                      style: AppTextTheme.normalBlack),
                                  TextSpan(
                                      text: 'Xem tại đây',
                                      style: AppTextTheme.normalBlue)
                                ],
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ButtonBottom(
                        text: PersonalConstant.PostSell,
                        color: _agreePolicy ? AppColors.green : AppColors.grey5,
                        onTap: () {},
                        paddingHorizontal: 8,
                        haveIcon: false,
                        textStyle: AppTextTheme.medium.copyWith(
                            color: _agreePolicy
                                ? AppColors.white
                                : AppColors.grey7),
                      )
                    ],
                  ),
                ), // dịch vụ chuyển hàng
              ],
            ),
          ),
        ));
  }
}
void customModalBottomSheet(BuildContext context) {
  showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => DraggableScrollableSheet(
          minChildSize: 0.2,
          initialChildSize: 0.2,
          expand: false,
          builder: (_, controller) => CustomModalBottomSheet()));
}
// void customModalBottomSheet(BuildContext context, List<ItemCategory> list,
//     double x, IconData iconData, Function(int indexx) onPress) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     isDismissible: true,
//     shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
//     builder: (context) => DraggableScrollableSheet(
//       initialChildSize: x,
//       maxChildSize: x,
//       expand: false,
//       builder: (_, controller) => Column(
//         children: [
//           AppBar(
//             leading: IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: Icon(
//                 iconData,
//                 size: 20,
//                 color: Colors.black,
//               ),
//             ),
//             backgroundColor: Colors.white,
//             title: const Text(
//               'Thời trang',
//               style: TextStyle(fontSize: 16, color: Colors.black),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               controller: controller,
//               itemCount: list.length,
//               itemBuilder: (_, index) {
//                 return ListTile(
//                   title: Container(
//                     height: 48,
//                     padding: const EdgeInsets.only(left: 16, right: 18),
//                     child: Row(
//                       children: [
//                         Text(
//                           list[index].name,
//                           style: const TextStyle(
//                               color: Colors.black, fontSize: 14),
//                         ),
//                         Expanded(child: Container()),
//                         const Icon(
//                           Icons.arrow_forward_ios,
//                           color: Colors.black,
//                           size: 15,
//                         )
//                       ],
//                     ),
//                   ),
//                   onTap: () {
//                     onPress(index);
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

void customModalBottomSheet2(BuildContext context, List<ItemCategory> list,
    double x, IconData iconData, Function(int indexx) onPress) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: x,
      maxChildSize: x,
      expand: false,
      builder: (_, controller) => const MyBottomSheetX(),
    ),
  );
}

void customModalBottomSheet4(
    BuildContext context, double x, Function(int indexx) onPress) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: x,
      maxChildSize: x,
      expand: false,
      builder: (_, controller) => const MyBottomSheetZ(),
    ),
  );
}

void customModalBottomSheet5(
    BuildContext context, double x, Function(int indexx) onPress) {
  showModalBottomSheet(
    backgroundColor: AppColors.grey100,
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: x,
      maxChildSize: x,
      expand: false,
      builder: (_, controller) => const MyBottomSheetY(),
    ),
  );
}

void customModalBottomSheet3(BuildContext context, List<ItemDepositPlace> list,
    double x, IconData iconData, Function(int indexx) onPress) {
  showModalBottomSheet(
    backgroundColor: AppColors.grey100,
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: x,
      maxChildSize: x,
      expand: false,
      builder: (_, controller) => Column(
        children: [
          AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                iconData,
                size: 20,
                color: Colors.black,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {},
                  child: const Text("Clear",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w400)))
            ],
            backgroundColor: Colors.white,
            title: const Text(
              'Chọn điểm ký gửi',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          Container(
              padding: const EdgeInsets.only(
                  left: 24, bottom: 16, top: 24, right: 40),
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  const Text(
                    "Chính sách",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean sit amet risus nec mauris bibendum blandit eu sit amet ex. Donec commodo rhoncus tempus.",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400)),
                  )
                ],
              )),
          Expanded(
            child: ListView.builder(
              controller: controller,
              itemCount: list.length,
              itemBuilder: (_, index) {
                return Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  height: 122,
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 15),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 48,
                        height: 48,
                        child: ClipOval(
                          child: SizedBox(
                            child: Image.asset(
                              list[index].pathImage,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 26,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            list[index].naneShop,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Text(
                              "Địa chỉ: ${list[index].address}",
                              overflow: TextOverflow.clip,
                              maxLines: 3,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            list[index].phone,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.greenText),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
              margin: const EdgeInsets.only(top: 20),
              color: Colors.white,
              alignment: Alignment.center,
              height: 83,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Clear",
                        style: TextStyle(color: AppColors.green, fontSize: 14),
                      )),
                  Text(
                    list[0].naneShop,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Chọn",
                        style: TextStyle(color: AppColors.green, fontSize: 14),
                      )),
                ],
              )),
        ],
      ),
    ),
  );
}

void customModalBottomSheet6(BuildContext context, IconData iconData) {
  showModalBottomSheet(
    backgroundColor: AppColors.backgroundIconBack,
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 0.9,
      expand: false,
      builder: (_, controller) => Column(
        children: [
          AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                iconData,
                size: 20,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            title: const Text(
              'Tạo địa chỉ bán hàng',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  height: 56,
                  child: TextField(
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Tên shop',
                        hintStyle:
                            TextStyle(color: Colors.black26, fontSize: 14)),
                  ),
                ), // tên shop
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  height: 56,
                  child: TextField(
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Số điện thoại',
                        hintStyle:
                            TextStyle(color: Colors.black26, fontSize: 14)),
                  ),
                ), // số điện thoại
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  height: 56,
                  child: TextField(
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Địa chỉ shop',
                        hintStyle:
                            TextStyle(color: Colors.black26, fontSize: 14)),
                  ),
                ), // địa chỉ shop
                const SizedBox(
                  height: 20,
                ),
                Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    height: 56,
                    padding:
                        const EdgeInsets.only(left: 16, top: 17, bottom: 17),
                    child: Row(
                      children: [
                        const Text(
                          "Tỉnh/Thành phố",
                          style: TextStyle(
                              color: Colors.black26,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                        Expanded(child: Container()),
                        const Icon(Icons.arrow_drop_down)
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    height: 56,
                    padding:
                        const EdgeInsets.only(left: 16, top: 17, bottom: 17),
                    child: Row(
                      children: [
                        const Text(
                          "Quận/Huyện",
                          style: TextStyle(
                              color: Colors.black26,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                        Expanded(child: Container()),
                        const Icon(Icons.arrow_drop_down)
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    height: 56,
                    padding:
                        const EdgeInsets.only(left: 16, top: 17, bottom: 17),
                    child: Row(
                      children: [
                        const Text(
                          "Phường/Xã",
                          style: TextStyle(
                              color: Colors.black26,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                        Expanded(child: Container()),
                        const Icon(Icons.arrow_drop_down)
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    height: 56,
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Loại địa chỉ",
                              style: TextStyle(
                                  color: Colors.black26,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12),
                            ),
                            Text(
                              "Shop bán hàng",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        const Icon(Icons.arrow_drop_down)
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Switch(
                      activeColor: Colors.green,
                      value: true,
                      onChanged: (value) {},
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text("Sử dụng địa chỉ này làm mặc định")
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            child: Container(
              decoration: const BoxDecoration(
                  color: AppColors.greenText,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              margin: const EdgeInsets.only(bottom: 35, left: 16, right: 16),
              alignment: Alignment.center,
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: const Text(
                "Thêm địa chỉ",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            onTap: () {
              Routes.instance.pop();
            },
          )
        ],
      ),
    ),
  );
}

class ItemCategory {
  String name;
  int id;

  ItemCategory({required this.id, required this.name});
}

class ItemDepositPlace {
  String naneShop;
  String address;
  String phone;
  String pathImage;

  ItemDepositPlace(
      {required this.naneShop,
      required this.address,
      required this.phone,
      required this.pathImage});
}

class ItemAddressShop {
  int id;
  String nameShop;
  String address;
  String phone;
  String addressStyle;

  ItemAddressShop(
      {required this.id,
      required this.nameShop,
      required this.address,
      required this.phone,
      required this.addressStyle});
}

class MyBottomSheetX extends StatefulWidget {
  const MyBottomSheetX({Key? key}) : super(key: key);

  @override
  _MyBottomSheetXState createState() => _MyBottomSheetXState();
}

class _MyBottomSheetXState extends State<MyBottomSheetX> {
  int value = 0;
  String a = "";
  List<ItemCategory> listItem3 = [
    ItemCategory(id: 1, name: 'Quần áo'),
    ItemCategory(id: 2, name: 'Giày dép'),
    ItemCategory(id: 3, name: 'Phụ kiện'),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.keyboard_arrow_left,
            size: 20,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Thời trang',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: listItem3.length,
              itemBuilder: (_, index) {
                return RadioListTile(
                  value: value,
                  groupValue: listItem3[index].id,
                  onChanged: (ind) {
                    setState(() {
                      value = listItem3[index].id;
                      a = listItem3[index].name;
                    });
                  },
                  title: Container(
                    height: 48,
                    padding: const EdgeInsets.only(left: 16, right: 18),
                    child: Row(
                      children: [
                        Text(
                          listItem3[index].name,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: GestureDetector(
        child: Container(
          decoration: const BoxDecoration(
              color: AppColors.greenText,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          margin: const EdgeInsets.only(bottom: 35, left: 16, right: 16),
          alignment: Alignment.center,
          height: 40,
          width: MediaQuery.of(context).size.width,
          child: Text(
            "Bán trong danh mục $a",
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
        onTap: () {
          Routes.instance.popAndNavigateTo(routeName: RouteName.postedForSale);
        },
      ),
    );
  }
}

class MyBottomSheetY extends StatefulWidget {
  const MyBottomSheetY({Key? key}) : super(key: key);

  @override
  _MyBottomSheetYState createState() => _MyBottomSheetYState();
}

class _MyBottomSheetYState extends State<MyBottomSheetY> {
  int value = 0;
  List<ItemAddressShop> list6 = [
    ItemAddressShop(
        id: 1,
        nameShop: "Phạm Hùng Vân",
        address: "Cách 1.5km - Ngõ 259, Số 43 Yên Hòa, Cầu Giấy, Hà Nội",
        phone: ' 033939388338',
        addressStyle: "Nhà riêng"),
    ItemAddressShop(
        id: 2,
        nameShop: "Phạm Hùng Long",
        address: "Cách 1.5km - Ngõ 259, Số 43 Yên Hòa, Cầu Giấy, Hà Nội",
        phone: ' 033939388338',
        addressStyle: "Công ty"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundIconBack,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            size: 20,
            color: AppColors.grey9,
          ),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Chọn địa chỉ bán hàng',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          getListAddr(),
          GestureDetector(
            child: Container(
                margin: const EdgeInsets.only(top: 20, bottom: 30),
                color: Colors.white,
                alignment: Alignment.center,
                height: 48,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add_circle_outline,
                          color: AppColors.greenText,
                        )),
                    const SizedBox(
                      width: 14,
                    ),
                    const Text(
                      "Thêm địa chỉ mới",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )),
            onTap: () {
              customModalBottomSheet6(context, Icons.arrow_back_ios);
            },
          ),
        ],
      ),
      bottomNavigationBar: GestureDetector(
        child: Container(
          decoration: const BoxDecoration(
              color: AppColors.greenText,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          margin: const EdgeInsets.only(bottom: 35, left: 16, right: 16),
          alignment: Alignment.center,
          height: 40,
          width: MediaQuery.of(context).size.width,
          child: const Text(
            "Sử dụng địa chỉ này",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
        onTap: () {
          Routes.instance.pop();
        },
      ),
    );
  }

  Widget getListAddr() {
    List<Widget> list = [];
    for (int i = 0; i < list6.length; i++) {
      list.add(item(list6[i]));
    }
    return Column(
      children: list,
    );
  }

  Widget item(ItemAddressShop model) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: RadioListTile(
        tileColor: Colors.white,
        value: value,
        groupValue: model.id,
        onChanged: (ind) {
          setState(() {
            value = model.id;
          });
        },
        title: Container(
          width: MediaQuery.of(context).size.width - 132,
          padding: const EdgeInsets.only(left: 16, right: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${model.nameShop} - ${model.phone}",
                style: const TextStyle(color: Colors.black, fontSize: 12),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                model.address,
                style: const TextStyle(color: Colors.black, fontSize: 12),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                model.addressStyle,
                style:
                    const TextStyle(color: AppColors.greenText, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyBottomSheetZ extends StatefulWidget {
  const MyBottomSheetZ({Key? key}) : super(key: key);

  @override
  _MyBottomSheetZState createState() => _MyBottomSheetZState();
}

class _MyBottomSheetZState extends State<MyBottomSheetZ> {
  int value = 0;

  List<ItemCategory> listItem5 = [
    ItemCategory(id: 1, name: 'Mới'),
    ItemCategory(id: 2, name: 'Đã sử dụng - như mới'),
    ItemCategory(id: 3, name: 'Đã sử dụng - còn tốt'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundIconBack,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            size: 20,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Tình trạng',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text(
                "Clear",
                style: TextStyle(color: AppColors.green, fontSize: 14),
              )),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: listItem5.length,
              itemBuilder: (_, index) {
                return Container(
                  margin: const EdgeInsets.only(top: 5),
                  color: Colors.white,
                  child: RadioListTile(
                    value: value,
                    groupValue: listItem5[index].id,
                    onChanged: (ind) {
                      setState(() {
                        value = listItem5[index].id;
                      });
                    },
                    title: Container(
                      height: 48,
                      padding: const EdgeInsets.only(left: 16, right: 18),
                      child: Row(
                        children: [
                          Text(
                            listItem5[index].name,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14),
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
