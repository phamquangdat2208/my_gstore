import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:my_gstore/common/global_app_cache/global_app_catch.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/common/ultils/format_utils.dart';
import 'package:my_gstore/presentation/journey/feature/auth/individual/String%20Constant/personal_const.dart';
import 'package:my_gstore/presentation/journey/feature/auth/individual/Widget/custom_textfield_with_label_inside.dart';

import '../../../injector_container.dart';

class PostSellProductTextFieldNumber extends StatelessWidget {
  final TextEditingController controller;
  final bool readOnly;

  const PostSellProductTextFieldNumber({
    Key? key,
    required this.controller,
    this.readOnly = false,
  }) : super(key: key);
  //
  // void _onDetailLimit() {
  //   Routes.instance.navigateTo(RouteName.limitProductDetailScreen);
  // }

  @override
  Widget build(BuildContext context) {
    int numberLimit =
        injector<GlobalAppCache>().profileModel?.limitQuantityProduct ?? 1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text.rich(
            TextSpan(
              style: AppTextTheme.normalGrey,
              children: <TextSpan>[
                TextSpan(
                  text: 'Giới hạn đăng tối đa: $numberLimit SP ',
                  style: AppTextTheme.normalGrey,
                ),
                TextSpan(
                    text: 'Chi tiết',
                    style: AppTextTheme.normalBlue.copyWith(
                      decoration: TextDecoration.underline,
                    )),
              ],
            ),
          ),
        ),
        CustomTextFieldWithLabelInside(
          hintText: translate(PersonalConstant.entity),
          controller: controller,
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.done,
          readOnly: readOnly,
          validator: (String? text) {
            bool checkNumber = FormatUtils.checkNumber(text ?? '');
            if (!checkNumber) {
              return PersonalConstant.checkNumber;
            }
            if (text?.isEmpty ?? true) {
              return 'Nhập số lượng sản phẩm';
            }
            if (int.parse(controller.text) > numberLimit) {
              return 'Tối đa $numberLimit SP';
            }
            return null;
          },
        ),
      ],
    );
  }
}
