import 'package:flutter/material.dart';

import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';

class LabeledCheckBoxComponent extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final String quantity;
  final String srcImg;

  const LabeledCheckBoxComponent(
      {Key? key,
        required this.label,
        required this.value,
        required this.onChanged,
        required this.quantity,
        required this.srcImg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        padding: const EdgeInsets.only(right: 20.0, left: 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: AppColors.grey4),
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Row(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 40.0,
                          child: Image.asset(
                            srcImg,
                            width: 20,
                            height: 20.0,
                          ),
                        )
                      ],
                    ),
                    Text(
                      label,
                      style: AppTextTheme.normalRoboto,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      '($quantity)',
                      style: AppTextTheme.normalGrey,
                    )
                  ],
                )),
            Checkbox(
              activeColor: AppColors.greenText,
              value: value,
              onChanged: (newValue) {
                onChanged(newValue!);
              },
            ),
          ],
        ),
      ),
    );
  }
}