import 'package:flutter/material.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/button_component_icon.dart';

class IndividualScreen extends StatefulWidget {
  const IndividualScreen({Key? key}) : super(key: key);

  @override
  _IndividualScreenState createState() => _IndividualScreenState();
}

class _IndividualScreenState extends State<IndividualScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 136.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/images/mock_top_back_ground_home.png",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.settings,
                                color: Colors.white,
                              ),
                              IconButton(
                                onPressed: () {
                                  // go to my profile
                                },
                                icon: Icon(
                                  Icons.create,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        height: 28.0,
                        width: MediaQuery.of(context).size.width,
                      )
                    ],
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: MediaQuery.of(context).size.width * 1 / 2 - 28,
                    child: Stack(
                      children: [
                        Container(
                          width: 56.0,
                          height: 56.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.white, width: 1.0),
                            color: Color(0xffF5F5F5),
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/profile/myAvt.png',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Bùi Nguyễn Nam Sơn',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                '24 liked',
                                style: AppTextTheme.normalGrey,
                              ),
                              Text('24 liked', style: AppTextTheme.normalGrey),
                              Text('24 liked', style: AppTextTheme.normalGrey),
                              Text('24 liked', style: AppTextTheme.normalGrey),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ButtonWidget(
                              onPressed: () {
                                //go to post product
                              },
                              buttonTitle: 'Đăng bán sản phẩm',
                              backGrButton: AppColors.greenText),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // go to
                                },
                                child: Container(
                                  width: 84.0,
                                  height: 102.0,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        '',
                                        width: 40.0,
                                        height: 40.0,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        '',
                                        textAlign: TextAlign.center,
                                        style: AppTextTheme.normalGrey9,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () {
                  // go to
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: AppColors.grey4),
                    ),
                  ),
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  height: 48.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 32.0,
                                height: 32.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(''),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                '',
                                style: AppTextTheme.normalGrey,
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '',
                            style: AppTextTheme.normalBlack,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: AppColors.grey7,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
