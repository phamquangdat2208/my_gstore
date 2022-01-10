import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_event.dart';
import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_state.dart';
import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/common/constants/string_const.dart';
import 'package:my_gstore/common/customs/custom_gesturedetactor.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/presentation/journey/feature/screens/screen_container.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/button_bottom.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../../injector_container.dart';
import '../../../../routes.dart';
import 'otp_cubit.dart';

class ConfirmScreen extends StatefulWidget {
  final String phoneNumber;

  const ConfirmScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _ConfirmScreenState createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> with CodeAutoFill {
  String _otp = '';
  bool _enable = true;
  final _focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    if (Platform.isAndroid) {
      listenForCode();
    }
    _focusNode.requestFocus();
    _controller.addListener(() {
      if (_controller.text.length == 6) {
        _enable = true;
      } else {
        _enable = false;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void codeUpdated() {
    _controller.text = code!;
    if (code != null && code!.isNotEmpty) {
      _login();
    }
  }

  void _login() async {
    if (_otp.length == 6) {
      final success =
          await injector<OtpCubit>().verifyOtp(widget.phoneNumber, _otp);
      if (success) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContainerScreen(),
          ),
        );
      }
    } else {
      injector<SnackBarBloc>().add(ShowSnackbarEvent(
        content: StringConst.someThingWentWrong,
        type: SnackBarType.warning,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nhập mã xác nhận',
                      style: AppTextTheme.title,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    const Text(
                      'Bạn không nhận được mã xác nhận đăng nhập?',
                      style: AppTextTheme.normalGrey,
                    ),
                    CustomGestureDetector(
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(0, 16.0, 0, 16.0),
                        child: Text(
                          StringConst.getNewOTP,
                          style: AppTextTheme.normalLinkGreen,
                        ),
                      ),
                    )
                  ],
                ),
                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  obscureText: false,
                  controller: _controller,
                  autoDismissKeyboard: false,
                  focusNode: _focusNode,
                  enableActiveFill: true,
                  animationType: AnimationType.fade,
                  cursorColor: AppColors.grey4,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    fieldHeight: 56,
                    fieldWidth: (MediaQuery.of(context).size.width - 64) / 6,
                    errorBorderColor: Colors.red,
                    activeColor: AppColors.grey3,
                    inactiveFillColor: AppColors.grey3,
                    activeFillColor: AppColors.grey3,
                    selectedFillColor: AppColors.grey3,
                    inactiveColor: AppColors.grey3,
                    selectedColor: AppColors.grey3,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  onChanged: (value) {
                    _otp = value;
                    setState(() {});
                  },
                ),
                const Spacer(),
                ButtonBottom(
                  color: _enable ? AppColors.primaryColor : AppColors.grey5,
                  paddingHorizontal: 0,
                  text: StringConst.login,
                  haveIcon: false,
                  onTap: _enable ? _login : () {},
                  textStyle: AppTextTheme.medium.copyWith(
                      color: _enable ? AppColors.white : AppColors.grey7),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
