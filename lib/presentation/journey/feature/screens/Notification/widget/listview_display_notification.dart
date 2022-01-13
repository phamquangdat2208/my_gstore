import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_gstore/common/bloc/event_bus/event_bus_bloc.dart';
import 'package:my_gstore/common/bloc/event_bus/event_bus_event.dart';
import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/common/network/app_client.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/presentation/journey/feature/screens/Notification/model/notification_model.dart';

import '../../../../../injector_container.dart';

class NotificationItem extends StatefulWidget {
  final NotificationModels notificationModel;
  const NotificationItem({
    Key? key,
    required this.notificationModel,
  }) : super(key: key);

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  void makeRead(int? notiId) async {
    List<NotificationModels> result = [];
    injector<AppClient>().get('Customer/MakeReadNofifyCation?id=${notiId}');
    result.clear();
    final data = await injector<AppClient>().get(
        'Customer/GetNofifyCationHistory?customerid=${notiId}&page=4&pagesize=12&type=0&isRead=2');
    data['Data'].forEach((e) {
      result.add(NotificationModels.fromJson(e));
    });
    // injector<EventBusBloc>().add(EventBusRequestInitDataNotificationEvent(
    //     count: result.where((element) => !element.isRead).toList().length));
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
      makeRead(widget.notificationModel.iD);
      },
      child: Container(
        width: double.infinity,
        color: (widget.notificationModel.isRead ?? false)
            ? AppColors.white
            : Colors.teal.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 12),
              Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: AppColors.grey4,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(20),
                  child: SvgPicture.asset(
                    IconConst.notification,
                    color: (widget.notificationModel.isRead ?? false)
                        ? AppColors.grey7
                        : null,
                  )),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.notificationModel.type == 0
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              widget.notificationModel.title ?? '',
                              style: AppTextTheme.mediumBlack,
                            ),
                          )
                        : const SizedBox(),
                    Text(
                      widget.notificationModel.content ?? '',
                      style: AppTextTheme.normalGrey9.copyWith(fontSize: 16),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        SvgPicture.asset(IconConst.iconClock),
                        const SizedBox(width: 8),
                        Text(
                          widget.notificationModel.dateTimeText ?? '',
                          style: AppTextTheme.normalGrey,
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              const SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }
}
