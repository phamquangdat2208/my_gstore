import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gstore/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:my_gstore/common/bloc/loading_bloc/loading_event.dart';
import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/common/constants/image_constant.dart';
import 'package:my_gstore/common/constants/key_save_data_local.dart';
import 'package:my_gstore/common/customs/custom_gesturedetactor.dart';
import 'package:my_gstore/common/global_app_cache/global_app_catch.dart';
import 'package:my_gstore/common/local/local_app.dart';
import 'package:my_gstore/common/navigation/route_names.dart';
import 'package:my_gstore/common/network/app_client.dart';
import 'package:my_gstore/common/network/configs.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/common/ultils/common_util.dart';
import 'package:my_gstore/common/ultils/format_utils.dart';
import 'package:my_gstore/common/ultils/log_util.dart';
import 'package:my_gstore/presentation/journey/feature/auth/individual/cubit/individual_cubit.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/button_bottom.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/custom_cache_image_network.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/grey_sizebox.dart';
import '../../../../injector_container.dart';
import '../../../../routes.dart';
import 'Widget/icon_list_title.dart';
import 'Widget/individual_icon_center.dart';

class IndividualScreen extends StatefulWidget {
  const IndividualScreen({Key? key}) : super(key: key);

  @override
  _IndividualScreenState createState() => _IndividualScreenState();
}

void _logout() async {
  final localApp = injector<LocalApp>();
  try {
    localApp.saveStringSharePreference(KeySaveDataLocal.keySaveAccessToken, "");
    Routes.instance.navigateTo(RouteName.loginScreen);
  } catch (e) {
    // CommonUtils.handleException(injector<SnackBarBloc>(), e,
    //     methodName: ''); // bug hear
    Routes.instance.pop();
  } finally {
    injector<LoadingBloc>().add(FinishLoading());
  }
}

class _IndividualScreenState extends State<IndividualScreen> {
  IndividualCubit _individualCubit = injector<IndividualCubit>();
  late GlobalAppCache _globalAppCatch;

  @override
  void initState() {
    _globalAppCatch = injector<GlobalAppCache>();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    _globalAppCatch.profileModel?.imageTimeline == ''
                        ? Image(
                            image: AssetImage(ImageConstant.mockTopBackGround),
                            height: MediaQuery.of(context).size.height * 1 / 5,
                            fit: BoxFit.fitWidth,
                            width: double.infinity,
                          )
                        : CustomGestureDetector(
                            onTap: () {
                              Routes.instance
                                  .navigateTo(RouteName.updateProfileScreen);
                            },
                            child: CustomCacheImageNetwork(
                              url:
                                  _globalAppCatch.profileModel?.imageTimeline ??
                                      '',
                              height:
                                  MediaQuery.of(context).size.height * 1 / 5,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
                Positioned(
                    bottom: 0,
                    left: MediaQuery.of(context).size.width * 1 / 2 - 40,
                    child: Stack(
                      children: [
                        CustomGestureDetector(
                          onTap: () {
                            Routes.instance
                                .navigateTo(RouteName.updateProfileScreen);
                          },
                          child: Container(
                            decoration: new BoxDecoration(
                              border: Border.all(color: Colors.white, width: 1),
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: CustomCacheImageNetwork(
                                url: _globalAppCatch.profileModel?.avartaUrl ??
                                    '',
                                height:
                                    MediaQuery.of(context).size.width * 1 / 4,
                                width:
                                    MediaQuery.of(context).size.width * 1 / 4,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Text('${_globalAppCatch.profileModel?.fullName ?? ''}',
                    style: AppTextTheme.medium20PxBlack),
              ],
            ),
            CustomGestureDetector(
              onTap: (){
                Routes.instance.navigateTo(RouteName.postedForSale);
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 1 / 10,
                    16,
                    MediaQuery.of(context).size.width * 1 / 10,
                    16),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: AppColors.green.withOpacity(0.8),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.grey5.withOpacity(0.5),
                      offset: Offset(0, 3),
                      blurRadius: 7,
                      spreadRadius: 5,
                    )
                  ],
                ),
                child: Center(
                  child: Text(
                    'Đăng bán sản phẩm',
                    style: AppTextTheme.IndividualButtonWhite,
                  ),
                ),
              ),
            ),
            GreySizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
              child: Container(
                width: MediaQuery.of(context).size.width - 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PersonalItemCenterWidget(
                        icon: IconConst.personalOnSelling,
                        text: 'Quản lý sản phẩm',
                        onTap: () {
                          // if (!_logged()) {
                          //   return;
                          // }
                          // Routes.instance.navigateTo(RouteName.managerSalesScreen);
                        }),
                    PersonalItemCenterWidget(
                        icon: IconConst.personalManagerSale,
                        text: 'Quản lý doanh số',
                        onTap: () {
                          // if (!_logged()) {
                          //   return;
                          // }
                          // Routes.instance.navigateTo(RouteName.managerSalesScreen);
                        }),
                    PersonalItemCenterWidget(
                        icon: IconConst.personalNewOrder,
                        text: 'Đơn bán',
                        onTap: () {
                          // if (!_logged()) {
                          //   return;
                          // }
                          // Routes.instance.navigateTo(RouteName.managerSalesScreen);
                        }),
                  ],
                ),
              ),
            ),
            GreySizedBox(
              height: 16,
            ),
            ListTile(
              onTap: () {},
              leading: PersonalItemCustom(
                icon: IconConst.personalCart,
                height: 32,
                width: 32,
              ),
              title: Text(
                'Đang xử lý',
                style: AppTextTheme.mediumBlack14px
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: AppColors.grey8,
              ),
            ),
            Divider(
              height: 0,
            ),
            ListTile(
              onTap: () {},
              leading: PersonalItemCustom(
                icon: IconConst.personalShipping,
                height: 32,
                width: 32,
              ),
              title: Text(
                'Sản phẩm đang giao',
                style: AppTextTheme.mediumBlack14px
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: AppColors.grey8,
              ),
            ),
            Divider(
              height: 0,
            ),
            ListTile(
              onTap: () {},
              leading: PersonalItemCustom(
                icon: IconConst.personalSelDone,
                height: 32,
                width: 32,
              ),
              title: Text(
                'Đã nhận',
                style: AppTextTheme.mediumBlack14px
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: AppColors.grey8,
              ),
            ),
           GreySizedBox(height: 16),
            ListTile(
              onTap: () {},
              leading: PersonalItemCustom(
                icon: IconConst.personalUpgrade,
                height: 32,
                width: 32,
              ),
              title: Text(
                'Nâng cấp tài khoản',
                style: AppTextTheme.mediumBlack14px
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: AppColors.grey8,
              ),
            ),
            Divider(
              height: 0,
            ),
            ListTile(
              onTap: () {},
              leading: PersonalItemCustom(
                icon: IconConst.personalWallet,
                height: 32,
                width: 32,
              ),
              title: Text(
                'Tài khoản G-Store',
                style: AppTextTheme.mediumBlack14px
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${FormatUtils.formatCurrencyDoubleToString(_globalAppCatch.profileModel?.wallets)}',
                    style: AppTextTheme.normalRobotoRed,
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: AppColors.grey8,
                  )
                ],
              ),
            ),
            Divider(
              height: 0,
            ),
            ListTile(
              onTap: () {},
              leading: PersonalItemCustom(
                icon: IconConst.personalReward,
                height: 32,
                width: 32,
              ),
              title: Text(
                'Tài khoản thưởng',
                style: AppTextTheme.mediumBlack14px
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: AppColors.grey8,
              ),
            ),
            Divider(
              height: 0,
            ),
            ListTile(
                onTap: () {},
                leading: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: AppColors.pink.withOpacity(0.1),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: PersonalItemCustom(
                    icon: IconConst.gWalletIcon,
                    height: 24,
                    width: 24,
                  ),
                ),
                title: Text(
                  'Điểm cống hiến',
                  style: AppTextTheme.mediumBlack14px
                      .copyWith(fontWeight: FontWeight.w400),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: AppColors.grey8,
                )),
            Divider(
              height: 0,
            ),
            ListTile(
              onTap: () {},
              leading: PersonalItemCustom(
                icon: IconConst.childs,
                height: 32,
                width: 32,
              ),
              title: Text(
                'Đã giới thiệu',
                style: AppTextTheme.mediumBlack14px
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '0',
                    style: AppTextTheme.normalGreen,
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: AppColors.grey8,
                  )
                ],
              ),
            ),
            Divider(
              height: 0,
            ),
            ListTile(
              onTap: () {},
              leading: PersonalItemCustom(
                backgroundColor: AppColors.logoGreen.withOpacity(0.1),
                iconColor: AppColors.logoSkyBlue,
                icon: IconConst.logo,
                height: 32,
                width: 32,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'G-FAMILY',
                    style: AppTextTheme.smallBlack
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'FOUNDATION',
                    style: AppTextTheme.smallBlack
                        .copyWith(fontWeight: FontWeight.w200, fontSize: 10),
                  ),
                ],
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: AppColors.grey8,
              ),
            ),
            Divider(
              height: 0,
            ),
            ListTile(
              onTap: () {},
              leading: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: AppColors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: PersonalItemCustom(
                  icon: IconConst.transfer,
                  height: 24,
                  width: 24,
                ),
              ),
              title: Text(
                'Chuyển điểm',
                style: AppTextTheme.mediumBlack14px
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: AppColors.grey8,
              ),
            ),
            Divider(
              height: 0,
            ),
            ListTile(
              onTap: () {},
              leading: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: AppColors.yellow.withOpacity(0.1),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: PersonalItemCustom(
                  iconColor: AppColors.yellow,
                  icon: IconConst.personalRelationship,
                  height: 24,
                  width: 24,
                ),
              ),
              title: Text(
                'Quản lý điểm thưởng',
                style: AppTextTheme.mediumBlack14px
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: AppColors.grey8,
              ),
            ),
            Divider(
              height: 0,
            ),
            ListTile(
              onTap: () {},
              leading: PersonalItemCustom(
                icon: IconConst.personalLocation,
                height: 32,
                width: 32,
              ),
              title: Text(
                'Sổ địa chỉ',
                style: AppTextTheme.mediumBlack14px
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: AppColors.grey8,
              ),
            ),
            Divider(
              height: 0,
            ),
            ListTile(
              onTap: () {
                CommonUtils.runUrl(Configurations.urlPolicy);
              },
              leading: PersonalItemCustom(
                icon: IconConst.personalPolicy,
                height: 32,
                width: 32,
              ),
              title: Text(
                'Chính sách quy định',
                style: AppTextTheme.mediumBlack14px
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: AppColors.grey8,
              ),
            ),
            Divider(
              height: 0,
            ),
            ListTile(
              onTap: () {},
              leading: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: AppColors.grey6.withOpacity(0.1),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: PersonalItemCustom(
                  iconColor: AppColors.grey6,
                  icon: IconConst.personalSetting,
                  height: 24,
                  width: 24,
                ),
              ),
              title: Text(
                'Cài đặt chung',
                style: AppTextTheme.mediumBlack14px
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: AppColors.grey8,
              ),
            ),
            GreySizedBox(
              height: 16,
            ),
            ListTile(
              onTap: _logout,
              leading: PersonalItemCustom(
                icon: IconConst.personalLogout,
                height: 32,
                width: 32,
              ),
              title: Text(
                'Đăng xuất',
                style: AppTextTheme.mediumBlack14px
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: AppColors.grey8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
