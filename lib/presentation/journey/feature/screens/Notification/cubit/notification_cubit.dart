import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gstore/common/bloc/event_bus/event_bus_bloc.dart';
import 'package:my_gstore/common/bloc/event_bus/event_bus_event.dart';
import 'package:my_gstore/common/bloc/loading_bloc/loading_bloc.dart';
import 'package:my_gstore/common/bloc/loading_bloc/loading_event.dart';
import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:my_gstore/common/global_app_cache/global_app_catch.dart';
import 'package:my_gstore/common/model/product_model.dart';
import 'package:my_gstore/common/navigation/route_names.dart';
import 'package:my_gstore/common/network/app_client.dart';
import 'package:my_gstore/common/network/configs.dart';
import 'package:my_gstore/common/ultils/common_util.dart';
import 'package:my_gstore/presentation/journey/feature/screens/Notification/model/notification_model.dart';

import '../../../../../injector_container.dart';
import '../../../../../routes.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final AppClient appClient;
  final SnackBarBloc snackBarBloc;
  final GlobalAppCache globalAppCache;

  NotificationCubit(this.appClient, this.snackBarBloc, this.globalAppCache)
      : super(NotificationInitState());
  int _pageId = 1;
  int _pageSize = Configurations.pageSize;

  void getLoadData() async {
    try {
      emit(NotificationGettingDataState());

      final getNoti = await getNotifitcation(
          'Customer/GetNofifyCationHistory?customerid=${appClient.globalAppCatch.profileModel?.iD}&page=${_pageId}&pagesize=${_pageSize}&type=0&isRead=2');
      emit(NotificationGotDataState(getNoti));
    } catch (e) {
      emit(NotificationGotDataState([]));
      CommonUtils.handleException(snackBarBloc, e,
          methodName: 'getInitData NotificationCubit');
    } finally {
      injector<LoadingBloc>().add(FinishLoading());
    }
  }

  void getLoadMoreData() async {
    try {
      emit(NotificationLoadingMoreState(state.notifications));
      final getNotiData = await getNotifitcation(
          'Customer/GetNofifyCationHistory?customerid=${appClient.globalAppCatch.profileModel?.iD}&page=${++_pageId}&pagesize=${_pageSize}&type=0&isRead=2');
      if (getNotiData.isNotEmpty) {
        state.notifications?.addAll(getNotiData);
      }
      emit(NotificationGotDataState(
        state.notifications,
        isLastData: getNotiData.length < Configurations.pageSize,
      ));
    } catch (e) {
      CommonUtils.handleException(injector<SnackBarBloc>(), e,
          methodName: '_NotificationScreenState');
    } finally {
      injector<LoadingBloc>().add(FinishLoading());
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

//
  void makeRead(int? notiId) async {
    List<NotificationModels> result = [];
    injector<AppClient>().get('Customer/MakeReadNofifyCation?id=${notiId}');
    if (state.notifications?.isEmpty ?? true) {
      return;
    }
    for (int i = 0; i < state.notifications!.length; i++) {
      if (state.notifications![i].iD == notiId) {
        state.notifications![i].isRead = true;
        Routes.instance.navigateTo(RouteName.notificationDetail,arguments:result);
      }
    }
    emit(NotificationGotDataState(
      state.notifications,
    ));
    // result.clear();
    // final data = await injector<AppClient>().get(
    //     'Customer/GetNofifyCationHistory?customerid=${notiId}&page=4&pagesize=12&type=0&isRead=2');
    // data['Data'].forEach((e) {
    //   result.add(NotificationModels.fromJson(e));
    // });
    // injector<EventBusBloc>().add(EventBusRequestInitDataNotificationEvent(
    //     count: result.where((element) => !element.isRead).toList().length));
    // emit(NotificationGotDataState(
    //   result,
    // ));
  }
}
