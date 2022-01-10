import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gstore/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:my_gstore/common/bloc/loading_bloc/loading_event.dart';
import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:my_gstore/common/constants/key_save_data_local.dart';
import 'package:my_gstore/common/global_app_cache/global_app_catch.dart';
import 'package:my_gstore/common/local/local_app.dart';
import 'package:my_gstore/common/model/profile_model.dart';
import 'package:my_gstore/common/network/app_client.dart';
import 'package:my_gstore/common/network/app_header.dart';
import 'package:my_gstore/common/ultils/common_util.dart';

class OtpCubit extends Cubit<VerifyOtpState> {
  final SnackBarBloc snackBarBloc;
  final LoadingBloc loadingBloc;
  final AppClient appClient;
  final LocalApp localApp;
  final GlobalAppCache globalAppCache;

  OtpCubit(this.snackBarBloc, this.loadingBloc, this.appClient, this.localApp,
      this.globalAppCache)
      : super(VerifyOtpInitState());

  Future<bool> verifyOtp(String phone, String otp) async {
    try {
      loadingBloc.add(StartLoading());
      final data = await appClient.get(
          'Customer/ValidateToken?phone=$phone&token=$otp&tokenDevice=123');
      AppHeader appHeader = AppHeader();
      final accessToken = data['Data']['Token'];
      final refreshToken = data['Data']['RefreshToken'];
      await localApp.saveStringSharePreference(
          KeySaveDataLocal.keySaveAccessToken, accessToken);
      await localApp.saveStringSharePreference(
          KeySaveDataLocal.keySaveRefreshToken, refreshToken);
      appHeader.accessToken = accessToken;
      appHeader.lat = 21.030235;
      appHeader.lng = 105.761697;
      appClient.setHeader(appHeader);
      final dataProfile = await appClient.get('Customer/GetProfile');
      await localApp.saveStringSharePreference(
          KeySaveDataLocal.keySaveDataProfile, json.encode(dataProfile['Data']));
      final profileModel = ProfileModel.fromJson(dataProfile['Data']);
      globalAppCache.profileModel = profileModel;
      return true;
    } catch (e) {
      CommonUtils.handleException(snackBarBloc, e, methodName: 'verifyOtp');
    } finally {
      loadingBloc.add(FinishLoading());
    }
    return false;
  }
}

abstract class VerifyOtpState {}

class VerifyOtpInitState extends VerifyOtpState {}

class VerifyOtpGettingState extends VerifyOtpState {}

class VerifyOtpGotState extends VerifyOtpState {}

class VerifyOtpGetFailState extends VerifyOtpState {}
