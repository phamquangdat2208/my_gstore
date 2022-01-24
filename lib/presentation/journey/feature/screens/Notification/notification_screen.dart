import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gstore/common/customs/custom_circular_indicator.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/presentation/injector_container.dart';
import 'package:my_gstore/presentation/journey/feature/screens/Notification/cubit/notification_cubit.dart';
import 'package:my_gstore/presentation/journey/feature/screens/Notification/model/notification_model.dart';
import 'package:my_gstore/presentation/journey/feature/screens/Notification/widget/listview_display_notification.dart';
import 'package:my_gstore/presentation/journey/feature/screens/Notification/widget/notification_layout_top.dart';


import 'cubit/notification_state.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationCubit _notiCubit = injector<NotificationCubit>();
  ScrollController controller = ScrollController();
  bool _enableContinueLoadMore = true;

  void initState() {
    // _notiCubit.getLoadMoreData();
    _notiCubit.getLoadData();
    controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (controller.position.extentAfter < 100) {
      if (_enableContinueLoadMore) {
        _enableContinueLoadMore = false;
        _notiCubit.getLoadMoreData();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          title: Text(
            'Thông báo',
            style: AppTextTheme.title,
          ),
        ),
        body: SingleChildScrollView(
          controller: controller,
          child: Column(children: [
            SizedBox(height: 16),
            NotificationLayoutTop(),
            BlocBuilder<NotificationCubit, NotificationState>(
                bloc: _notiCubit,
                buildWhen: (_, state) {
                  return state is NotificationGettingDataState ||
                      state is NotificationGotDataState;
                },
                builder: (_, state) {
                  if (state is NotificationGettingDataState) {
                    return CustomCircularIndicator();
                  }
                  if (state is NotificationGotDataState &&
                      (state.notifications?.isNotEmpty ?? false)) {
                    if (!state.isLastData) {
                      _enableContinueLoadMore = true;
                    }
                    return getList(state.notifications);
                  }
                  return Text('loi');
                }),
            BlocBuilder<NotificationCubit, NotificationState>(
                bloc: _notiCubit,
                builder: (_, state) {
                  if (state is NotificationLoadingMoreState) {
                    return CircularProgressIndicator(color: AppColors.grey5);
                  }
                  return SizedBox();
                })
          ]),
        ));
  }
  Widget getList(List<NotificationModels>? list) {

    List<Widget> listW = [];
    for (int i = 0; i < list!.length; i++) {
      listW.add(NotificationItem(
        notificationModel: list[i],
      ));
    }
    return Column(
      children: listW,
    );
  }
}


