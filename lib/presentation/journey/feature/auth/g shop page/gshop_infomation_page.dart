import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gstore/common/constants/string_const.dart';
import 'package:my_gstore/common/model/gshop_model.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/presentation/journey/feature/auth/g%20shop%20page/widget/gshop_detail_sliver_appbar.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/Product%20Item/listview_product.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/listview_display_gshop.dart';
import 'package:my_gstore/presentation/routes.dart';
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
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          BlocBuilder<GShopPageCubit, GShopState>(
              bloc: _gShopCubit,
              builder: (_, state) {
                if (state is GShopGotDataState) {
                  return SliverPersistentHeader(
                    pinned: true,
                    delegate: GShopDetailSliverAppBar(
                        gshop: state.getGShop,
                        onFavourite: () {},
                        moveToCart: () {},
                        onIconMoreTap: () {},
                        onShare: () {
                          // _userReputationBloc.onShareUser(
                          //     _userEntity.iD,
                          //     ((_userEntity.numberTS ?? 0) <
                          //         ServicePackageConstant.gShopTS ||
                          //         !(_userEntity.isCompany ?? true)));
                        }),
                  );
                }
                return SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(),
                  pinned: true,
                );
              }),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
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
                              Row(
                                children: [
                                  Spacer(),
                                  Container(
                                      margin: EdgeInsets.all(16),
                                      width: 120,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
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
              ],
            ),
          )
        ],
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
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget(BuildContext context) {
    return new Container();
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
