import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:my_gstore/common/constants/login_constant.dart';
import 'package:my_gstore/common/network/configs.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';

class RecentOtpWidget extends StatefulWidget {
  final Function? resendOtp;

  const RecentOtpWidget({Key? key, this.resendOtp}) : super(key: key);

  @override
  _RecentOtpWidgetState createState() => _RecentOtpWidgetState();
}

class _RecentOtpWidgetState extends State<RecentOtpWidget> {
  Timer? _timer;
  int _countDown = Configurations.timeOutOTP;

  void _startTimer() {
    _countDown = Configurations.timeOutOTP;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_countDown < 1) {
            timer.cancel();
          } else {
            _countDown = _countDown - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 200)).then((value) => _startTimer());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          if (_countDown < 1) {
            widget.resendOtp!();
            _startTimer();
          }
        },
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: translate(LoginConstant.youDontReceiverOtp),
                  style: AppTextTheme.normalGrey.copyWith(fontSize: 16.0)),
              TextSpan(
                  text: translate(LoginConstant.reSendOtp),
                  style: AppTextTheme.normalPrimary.copyWith(
                    fontSize: 16.0,
                    color: (_countDown < 1
                        ? AppColors.primaryColor
                        : AppColors.grey7),
                  )),
              TextSpan(
                  text: ' ($_countDown)',
                  style: AppTextTheme.normalPrimary.copyWith(fontSize: 16.0)),
            ],
            style: DefaultTextStyle.of(context).style,
          ),
        ),
      ),
    );
  }
}
