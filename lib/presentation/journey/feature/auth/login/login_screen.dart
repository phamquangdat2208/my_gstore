import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/common/constants/image_constant.dart';
import 'package:my_gstore/common/constants/string_const.dart';
import 'package:my_gstore/common/customs/custom_scaffold.dart';
import 'package:my_gstore/common/navigation/route_names.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/presentation/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void _loginPhoneNumber() {
    Routes.instance.navigateTo(
      RouteName.loginWithPhoneNumber,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 1 / 6,
          ),
          SvgPicture.asset(
            ImageConstant.logo,
            width: MediaQuery.of(context).size.width / 2,
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            StringConst.appName,
            style: AppTextTheme.bigTitle,
          ),
          const Text(
            StringConst.textCompany,
            style: AppTextTheme.normalGrey,
          ),
          const SizedBox(
            height: 16.0,
          ),
          const Spacer(),
          InkWell(
            onTap: _loginPhoneNumber,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.logoGreen,
                  borderRadius: BorderRadius.circular(8.0)),
              height: 48.0,
              margin: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    IconConst.phone,
                    width: 22.0,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  const Text(
                    StringConst.loginWithPhoneNumber,
                    style: AppTextTheme.medium,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
