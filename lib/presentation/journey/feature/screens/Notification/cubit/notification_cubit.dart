
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gstore/common/bloc/event_bus/event_bus_bloc.dart';
import 'package:my_gstore/common/bloc/event_bus/event_bus_event.dart';
import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:my_gstore/common/global_app_cache/global_app_catch.dart';
import 'package:my_gstore/common/network/app_client.dart';
import 'package:my_gstore/common/ultils/common_util.dart';
import 'package:my_gstore/presentation/journey/feature/screens/Notification/model/notification_model.dart';

import '../../../../../injector_container.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final AppClient appClient;
  final SnackBarBloc snackBarBloc;
  final GlobalAppCache globalAppCache;
  NotificationCubit(this.appClient, this.snackBarBloc, this.globalAppCache)
      : super(NotificationInitState());
  void getInitData() async {
    try {
      emit(NotificationGettingDataState());
      final getNoti = await getNotifitcation(
          'Customer/GetNofifyCationHistory?customerid=1233&page=4&pagesize=12&type=0&isRead=2');
      emit(NotificationGotDataState(
        getNoti,
      ));
    } catch (e) {
      emit(NotificationGotDataState([]));
      CommonUtils.handleException(snackBarBloc, e,
          methodName: 'getInitData NotificationCubit');
    }
  }

  Future<List<NotificationModels>> getNotifitcation(String endPoint) async {
    List<NotificationModels> result = [];
    final data = await appClient.get(endPoint);
    data['Data'].forEach((e) {
      result.add(NotificationModels.fromJson(e));
    });
    return result;
  }

}

abstract class NotificationState {}

class NotificationInitState extends NotificationState {}

class NotificationGettingDataState extends NotificationState {}

class NotificationGotDataState extends NotificationState {
  final List<NotificationModels> getNoti;
  NotificationGotDataState(this.getNoti);
}
