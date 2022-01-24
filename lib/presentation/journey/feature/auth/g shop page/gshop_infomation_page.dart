import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gstore/common/constants/string_const.dart';
import 'package:my_gstore/common/customs/custom_gesturedetactor.dart';
import 'package:my_gstore/common/model/gshop_model.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/presentation/journey/feature/auth/g%20shop%20page/widget/gshop_page_center_widget.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/G%20Shop%20Items/listview_gshop.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/Product%20Item/listview_product.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/custom_cache_image_network.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/listview_display_gshop.dart';

import '../../../../injector_container.dart';
import 'cubit/gshop_infor_cubit.dart';

class GShopInforScreen extends StatefulWidget {
  GShopModels? gshop;

  GShopInforScreen({Key? key, required this.gshop}) : super(key: key);

  @override
  GShopInforScreenState createState() => GShopInforScreenState();
}

class GShopInforScreenState extends State<GShopInforScreen> {
  final GShopPageCubit _gShopCubit = injector<GShopPageCubit>();

  @override
  void initState() {
    _gShopCubit.getDataShop(widget.gshop?.iD);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: AppColors.logoGreen,
              shadowColor: Colors.transparent,
              expandedHeight: 280.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  widget.gshop?.fullname ?? '',
                  style: AppTextTheme.normalWhite,
                ),
                background: DecoratedBox(
                  position: DecorationPosition.foreground,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          colors: <Color>[
                            AppColors.logoGreen,
                            Colors.transparent
                          ],
                          end: Alignment.center)),
                  child: Stack(
                    children: [
                      CustomCacheImageNetwork(
                        height: MediaQuery.of(context).size.height * 1 / 3,
                        width: MediaQuery.of(context).size.width,
                        url: widget.gshop?.avartaUrl ?? 'User',
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 5,
                        left: 10,
                        child: Text(
                          widget.gshop?.address ?? '',
                          style: AppTextTheme.smallWhite,
                          maxLines: 1,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ];
        },
        body: SingleChildScrollView(
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: BlocBuilder<GShopPageCubit, GShopState>(
                bloc: _gShopCubit,
                builder: (_, state) {
                  if (state is GShopGettingDataState) {
                    return SizedBox();
                  }
                  if (state is GShopGotDataState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        GShopCenterWidget(userModel: state.getGShop),
                        Row(
                          children: [
                            Spacer(),
                            Container(
                                margin: EdgeInsets.all(16),
                                width: 120,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  gradient: LinearGradient(
                                    colors: AppColors.colorsGradient,
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(1),
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Đánh giá',
                                      style: AppTextTheme.normalBlack,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        Container(
                          color: AppColors.white,
                          width: MediaQuery.of(context).size.width,
                          child: ListViewDisplayProduct(
                            label: 'G-Mall',
                            productModel: state.getGMall,
                            haveIcon: true,
                          ),
                        ),
                        Container(
                          color: AppColors.white,
                          width: MediaQuery.of(context).size.width,
                          child: ListViewDisplayProduct(
                            label: 'Sản phẩm kí gửi',
                            productModel: state.getProductKG,
                            haveIcon: false,
                          ),
                        ),
                        Container(
                          color: AppColors.white,
                          width: MediaQuery.of(context).size.width,
                          child: ListViewDisplayProduct(
                            label: 'Sản phẩm tự bán',
                            productModel: state.getProductTB,
                            haveIcon: false,
                          ),
                        ),
                        Container(
                          color: AppColors.grey3,
                          child: ListViewDetailGShop(
                            notExpand: true,
                            label: StringConst.sameGShop,
                            GshopModel: state.getSampleGShop,
                          ),
                        )
                      ],
                    );
                  }
                  return SizedBox();
                },
              )),
        ),
      ),
      floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 35),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            FloatingActionButton(
              backgroundColor: AppColors.green,
              onPressed: () {},
              child: const Icon(Icons.directions),
            ),
            FloatingActionButton(
              backgroundColor: AppColors.green,
              onPressed: () {},
              child: const Icon(Icons.phone_in_talk),
            ),
          ])),
    ));
  }

//   ListView _buildListViewSPGMall(List<DataSPGMall> list1) {
//     return ListView.builder(
//         itemCount: list1.length,
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (context, index) {
//           return _itemWidgetSPGMall(list1[index]);
//         });
//   }
//
//   // Widget _itemWidgetSPGMall(DataSPGMall model) {
//   //   return CustomGestureDetector(
//   //     child: Container(
//   //         width: MediaQuery.of(context).size.width * 0.38,
//   //         margin: const EdgeInsets.only(left: 16),
//   //         child: Column(
//   //           crossAxisAlignment: CrossAxisAlignment.start,
//   //           mainAxisAlignment: MainAxisAlignment.center,
//   //           children: [
//   //             Container(
//   //                 width: MediaQuery.of(context).size.width * 0.38,
//   //                 height: MediaQuery.of(context).size.width * 0.38,
//   //                 decoration: const BoxDecoration(
//   //                   borderRadius: BorderRadius.all(Radius.circular(8.0)),
//   //                   gradient: LinearGradient(
//   //                     colors: AppColors.colorsGradient,
//   //                     begin: Alignment.centerLeft,
//   //                     end: Alignment.centerRight,
//   //                   ),
//   //                 ),
//   //                 child: Container(
//   //                     margin: const EdgeInsets.all(1.0),
//   //                     child: ClipRRect(
//   //                       borderRadius: BorderRadius.circular(8.0),
//   //                       child: model.urlPicture != null
//   //                           ? Image.network(
//   //                               "${model.urlPicture}",
//   //                               fit: BoxFit.cover,
//   //                             )
//   //                           : Image.asset("assets/homes/img_g_mall.png",
//   //                               fit: BoxFit.cover),
//   //                     ))),
//   //             Container(
//   //               height: 30,
//   //               margin: const EdgeInsets.only(top: 8),
//   //               child: Text(
//   //                 model.name ?? "",
//   //                 maxLines: 2,
//   //                 style: const TextStyle(
//   //                     fontSize: 14,
//   //                     fontWeight: FontWeight.w500,
//   //                     color: AppColors.grey9),
//   //               ),
//   //             ),
//   //             const SizedBox(
//   //               height: 4,
//   //             ),
//   //             Container(
//   //               alignment: Alignment.center,
//   //               child: Row(
//   //                 children: [
//   //                   Image.asset(
//   //                     "assets/homes/icon_khoang_cach.png",
//   //                     width: 14,
//   //                     height: 14,
//   //                   ),
//   //                   const SizedBox(
//   //                     width: 4,
//   //                   ),
//   //                   Text("${(model.km)?.toStringAsFixed(2) ?? ""} km  .  ",
//   //                       style: const TextStyle(
//   //                           fontSize: 10,
//   //                           fontWeight: FontWeight.w400,
//   //                           color: AppColors.grey7)),
//   //                   Image.asset(
//   //                     "assets/homes/star.png",
//   //                     width: 13.23,
//   //                     height: 12.64,
//   //                   ),
//   //                   const SizedBox(
//   //                     width: 4,
//   //                   ),
//   //                   Text("${model.avgRating ?? 0.0}(${model.ratings ?? 0})",
//   //                       style: const TextStyle(
//   //                           fontSize: 10,
//   //                           fontWeight: FontWeight.w400,
//   //                           color: AppColors.grey7))
//   //                 ],
//   //               ),
//   //             ),
//   //             const SizedBox(
//   //               height: 8,
//   //             ),
//   //             Container(
//   //               height: 1,
//   //               color: AppColors.grey4,
//   //             ),
//   //             const SizedBox(
//   //               height: 5,
//   //             ),
//   //             SizedBox(
//   //                 width: 200,
//   //                 child: Row(
//   //                   children: [
//   //                     Text(
//   //                       "${model.priceNew} đ",
//   //                       style: const TextStyle(
//   //                           color: AppColors.pink,
//   //                           fontSize: 14,
//   //                           fontWeight: FontWeight.w400,
//   //                           fontStyle: FontStyle.normal),
//   //                     ),
//   //                   ],
//   //                 )),
//   //           ],
//   //         )),
//   //     onTap: () {
//   //       Routes.instance
//   //           .navigateTo(RouteName.productDetails, arguments: model.iD);
//   //     },
//   //   );
//   // }
//
//   Widget _buildListView2(List<DataGShop> list1) {
//     List<Widget> _widgets = [];
//     for (var index = 0; index < list1.length; index++) {
//       _widgets.add(_itemWidget2(list1[index]));
//     }
//     return Column(
//       children: _widgets,
//     );
//   }
//
//   Widget _itemWidget2(DataGShop model) {
//     return CustomGestureDetector(
//       child: Container(
//           alignment: Alignment.center,
//           height: 154,
//           decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.all(Radius.circular(8.0))),
//           width: MediaQuery.of(context).size.width,
//           margin:
//               const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 4),
//           padding: const EdgeInsets.only(left: 16),
//           child: Row(
//             children: [
//               SizedBox(
//                 width: 122,
//                 height: 122,
//                 child: model.avartaUrl != null
//                     ? Image.network(
//                         model.avartaUrl ?? "",
//                         fit: BoxFit.cover,
//                       )
//                     : Image.asset("assets/homes/img_g_mall.png",
//                         fit: BoxFit.cover),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context).size.width - 186,
//                     margin: const EdgeInsets.only(left: 16, top: 16),
//                     child: Text(
//                       model.fullname ?? "",
//                       maxLines: 2,
//                       style: const TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: AppColors.grey9),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 4,
//                   ),
//                   Container(
//                     width: MediaQuery.of(context).size.width - 186,
//                     margin: const EdgeInsets.only(left: 16),
//                     child: Text(
//                       model.address ?? "",
//                       maxLines: 2,
//                       overflow: TextOverflow.visible,
//                       style: AppTextTheme.style12pxGrey8,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   Container(
//                     alignment: Alignment.center,
//                     margin: const EdgeInsets.only(left: 16),
//                     child: Row(
//                       children: [
//                         Image.asset(
//                           "assets/homes/star.png",
//                           width: 13.23,
//                           height: 12.64,
//                         ),
//                         const SizedBox(
//                           width: 4,
//                         ),
//                         model.ratings != null
//                             ? Text("${model.avgRating}(${model.ratings})",
//                                 style: const TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                     color: AppColors.grey7))
//                             : const Text("0.0(0)",
//                                 style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                     color: AppColors.grey7)),
//                         const SizedBox(
//                           width: 16,
//                         ),
//                         Image.asset(
//                           "assets/homes/icon_time.png",
//                           width: 14,
//                           height: 14,
//                         ),
//                         const SizedBox(
//                           width: 4,
//                         ),
//                         Text("${(model.km)?.toStringAsFixed(2)} km",
//                             style: const TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w400,
//                                 color: AppColors.grey7)),
//                       ],
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           )),
//       onTap: () {
//         Routes.instance.popAndNavigateTo(
//             routeName: RouteName.gShopPage,
//             arguments: DataSentGShop(
//                 pathImage: model.avartaUrl ?? "",
//                 name: model.fullname ?? "",
//                 id: model.iD!));
//       },
//     );
//   }
// }
}
