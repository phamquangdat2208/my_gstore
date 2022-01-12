import 'package:flutter/material.dart';

import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';

class PersonalItemCenterWidget extends StatelessWidget {
  final String? text;
  final String? highLightText;
  final String? icon;
  final Function? onTap;

  const PersonalItemCenterWidget({Key? key, this.text, this.icon, this.onTap,this.highLightText=''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: (){
          onTap!();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon??'',
              width: 48.0,
              height: 48.0,
            ),
            const SizedBox(height: 8.0),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: text,
                      style: AppTextTheme.normalGrey9.copyWith(fontSize: 16.0)),
                  TextSpan(
                      text: highLightText,
                      style: AppTextTheme.normalGrey9
                          .copyWith(fontSize: 16.0, color: AppColors.yellow)),
                ],
                style: DefaultTextStyle.of(context).style,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
