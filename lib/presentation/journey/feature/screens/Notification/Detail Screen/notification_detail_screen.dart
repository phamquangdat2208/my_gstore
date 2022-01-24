import 'package:flutter/material.dart';
import 'package:my_gstore/common/customs/custom_gesturedetactor.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/presentation/journey/feature/screens/Notification/model/notification_model.dart';
import 'package:my_gstore/presentation/routes.dart';
class NotificationDetailScreen extends StatelessWidget {
  final NotificationModels? notificationModels;
   NotificationDetailScreen({Key? key,this.notificationModels}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      appBar: AppBar(
        leading: CustomGestureDetector(
          onTap: (){
            Routes.instance.pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.keyboard_arrow_left,color: AppColors.black,),
          ),
        ),
        backgroundColor: AppColors.white,
        elevation: 0.2,
        title: Text(notificationModels?.title??'',style: AppTextTheme.mediumBlack,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(notificationModels?.content??'',style: AppTextTheme.normalRobotoBlack,),
      ),
    );
  }
}

