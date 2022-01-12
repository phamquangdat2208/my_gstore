import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:my_gstore/common/global_app_cache/global_app_catch.dart';
import 'package:my_gstore/common/network/app_client.dart';
import 'package:my_gstore/common/ultils/common_util.dart';
import '../../../../../injector_container.dart';

class IndividualCubit extends Cubit<IndividualState> {
  final AppClient appClient;
  final SnackBarBloc snackBarBloc;
  final GlobalAppCache globalAppCache;
  IndividualCubit(this.appClient, this.snackBarBloc, this.globalAppCache)
      : super(IndividualInitState());
  void getInitData() async {
    try {
      emit(IndividualGettingDataState());
      GlobalAppCache appCache = injector<GlobalAppCache>();

      emit(IndividualGotDataState());

    } catch (e) {
      emit(IndividualGotDataState());
      CommonUtils.handleException(snackBarBloc, e,
          methodName: 'getInitData IndividualCubit');
    }
  }

}

abstract class IndividualState {}

class IndividualInitState extends IndividualState {}

class IndividualGettingDataState extends IndividualState {}

class IndividualGotDataState extends IndividualState {

}
