import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gstore/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:my_gstore/common/bloc/loading_bloc/loading_event.dart';
import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:my_gstore/common/network/app_client.dart';
import 'package:my_gstore/common/ultils/common_util.dart';

class LoginWithPhoneCubit extends Cubit<LoginWithPhoneState> {
  final SnackBarBloc snackBarBloc;
  final LoadingBloc loadingBloc;
  final AppClient appClient;
  LoginWithPhoneCubit(this.snackBarBloc, this.loadingBloc, this.appClient)
      : super(LoginWithPhoneInitState());

  Future<bool> requestOtpAuth(String phone) async {
    try {
      loadingBloc.add(StartLoading());
      await appClient.get('Customer/login?phone=$phone');
      return true;
    } catch (e) {
      CommonUtils.handleException(snackBarBloc, e,
          methodName: 'requestOtpAuth');
    } finally {
      loadingBloc.add(FinishLoading());
    }
    return false;
  }
}

abstract class LoginWithPhoneState {}

class LoginWithPhoneInitState extends LoginWithPhoneState {}

class LoginWithPhoneGettingState extends LoginWithPhoneState {}

class LoginWithPhoneGotState extends LoginWithPhoneState {}

class LoginWithPhoneGetFailState extends LoginWithPhoneState {}
