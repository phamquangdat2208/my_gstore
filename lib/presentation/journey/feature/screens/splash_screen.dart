import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/common/constants/key_save_data_local.dart';
import 'package:my_gstore/common/customs/custom_scaffold.dart';
import 'package:my_gstore/common/global_app_cache/global_app_catch.dart';
import 'package:my_gstore/common/local/local_app.dart';
import 'package:my_gstore/common/model/profile_model.dart';
import 'package:my_gstore/common/navigation/route_names.dart';
import 'package:my_gstore/common/network/app_client.dart';
import 'package:my_gstore/common/network/app_header.dart';
import 'package:my_gstore/presentation/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../injector_container.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _initData();
    super.initState();
  }
  void _initData() async {
    final localApp = injector<LocalApp>();
    bool? showWelcome = localApp.getBool(KeySaveDataLocal.keySaveWelcomeScreen);
    await Future.delayed(Duration(milliseconds: 300));
    if (showWelcome == null) {
      localApp.saveBool(KeySaveDataLocal.keySaveWelcomeScreen, true);
      Routes.instance.navigateTo(RouteName.onBoardingScreen);
      return;
    }
    String? accessToken =
    localApp.getStringSharePreference(KeySaveDataLocal.keySaveAccessToken);
    if (accessToken == null) {
      Routes.instance.navigateTo(RouteName.loginScreen);
      return;
    }
    AppHeader appHeader = AppHeader();
    appHeader.accessToken = accessToken;
    appHeader.lat = 21.030235;
    appHeader.lng = 105.761697;

    injector<AppClient>().setHeader(appHeader);
    final dataProfileString =
    localApp.getStringSharePreference(KeySaveDataLocal.keySaveDataProfile);
    if (dataProfileString != null) {
      final profileModel =
      ProfileModel.fromJson(json.decode(dataProfileString));
      injector<GlobalAppCache>().profileModel = profileModel;
    }
    Routes.instance.navigateAndRemove(RouteName.containerScreen);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              IconConst.logo,
              width: 187,
              height: 187,
            )
          ],
        ),
      ),
    );
  }
}
