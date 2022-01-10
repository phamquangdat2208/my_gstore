import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:my_gstore/common/constants/image_constant.dart';
import 'package:my_gstore/common/constants/string_const.dart';
import 'package:my_gstore/common/navigation/route_names.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/presentation/routes.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var OnBoardingListBody = [
    'Tham gia cộng đồng G-STORE để giao lưu, chia sẻ và nhận các thông báo về tin tức kinh tế, thị trường trao đổi mua bán hàng hóa, dịch vụ.',
    'Đắm chìm vào các dịch vụ giải trí chất lượng được cộng đồng chọn lọc chia sẻ.',
    'Cùng nhau chia sẻ, trao tặng những giá trị của cuộc sống, từ hàng hóa, các dịch vụ mua sắm, trải nghiệm',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 1.2 / 4.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 16.0,
                    ),
                    Image.asset(
                      ImageConstant.logoPng,
                      width: MediaQuery.of(context).size.width * 1 / 3,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const Text(
                      StringConst.appName,
                      style: AppTextTheme.medium20PxBlack,
                    ),
                    const Text(
                      StringConst.textCompany,
                      style: AppTextTheme.smallGrey,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 3.4 / 5,
                child: IntroductionScreen(
                  color: AppColors.primaryColor,
                  showDoneButton: true,
                  showNextButton: true,
                  showSkipButton: false,
                  next: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(StringConst.next),
                      Icon(Icons.keyboard_arrow_right),
                    ],
                  ),
                  done: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        StringConst.done,
                      ),
                      Icon(Icons.keyboard_arrow_right),
                    ],
                  ),
                  onDone: () {
                    Routes.instance.navigateTo(RouteName.loginScreen);
                  },
                  pages: [
                    PageViewModel(
                      useScrollView: true,
                      decoration:
                          PageDecoration(titleTextStyle: TextStyle(height: 0)),
                      image: Image.asset(ImageConstant.splashBackgroundOne),
                      titleWidget: Text(
                        OnBoardingListBody[0],
                        textAlign: TextAlign.center,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextTheme.normalGrey,
                      ),
                      body: '',
                    ),
                    PageViewModel(
                      useScrollView: true,
                      image: Image.asset(ImageConstant.splashBackgroundTwo),
                      titleWidget: Text(
                        OnBoardingListBody[1],
                        textAlign: TextAlign.center,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextTheme.normalGrey,
                      ),
                      body: '',
                    ),
                    PageViewModel(
                      useScrollView: true,
                      image: Image.asset(ImageConstant.splashBackgroundThree),
                      titleWidget: Text(
                        OnBoardingListBody[2],
                        textAlign: TextAlign.center,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextTheme.normalGrey,
                      ),
                      body: '',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
