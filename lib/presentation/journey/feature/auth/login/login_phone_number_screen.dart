import 'package:flutter/material.dart';
import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/common/constants/string_const.dart';
import 'package:my_gstore/common/customs/custom_scaffold.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/common/ultils/validate_ultil.dart';
import 'package:my_gstore/presentation/journey/feature/auth/otp/confirm_screen.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/button_component_icon.dart';

import '../../../../injector_container.dart';
import '../../../../routes.dart';
import 'cubit/login_with_phone_cubit.dart';

class LoginWithPhoneNumberScreen extends StatefulWidget {
  const LoginWithPhoneNumberScreen({Key? key}) : super(key: key);

  @override
  _LoginWithPhoneNumberScreenState createState() =>
      _LoginWithPhoneNumberScreenState();
}

class _LoginWithPhoneNumberScreenState
    extends State<LoginWithPhoneNumberScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginWithPhoneCubit _loginWithPhoneCubit = injector<LoginWithPhoneCubit>();
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Routes.instance.pop();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          color: AppColors.grey4,
                          borderRadius: BorderRadius.circular(50.0)),
                      width: 38.0,
                      height: 38.0,
                      child: Image.asset(
                        IconConst.back,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Column(
                    children: const [
                      Text(
                        'Nhập số điện thoại của bạn',
                        style: AppTextTheme.title,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Chúng tôi sẽ gửi gửi cho bạn một tin nhắn với mã xác nhận đăng nhập',
                        style: AppTextTheme.normalGrey,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    cursorColor: AppColors.logoGreen,
                    decoration: const InputDecoration(
                      fillColor: AppColors.grey7,
                      labelText: 'Phone Number',
                      labelStyle: AppTextTheme.normalGrey,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.logoGreen, width: 2),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    validator: ValidateUtil.validPhone,
                    controller: _phoneController,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16.0),
              child: ButtonWidget(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      final success = await _loginWithPhoneCubit
                          .requestOtpAuth(_phoneController.text);
                      if (success) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConfirmScreen(
                              phoneNumber: _phoneController.text,
                            ),
                          ),
                        );
                      }
                    }
                  },
                  buttonTitle: StringConst.continueText,
                  backGrButton: AppColors.logoGreen),
            ),
          ],
        ),
      ),
    );
  }
}
