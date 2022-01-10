import 'package:flutter/material.dart';
import 'package:my_gstore/common/component/updating.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';

import 'news_body_contents.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Tin tức',
            style: AppTextTheme.title,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.black,
                size: 24.0,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.tune_outlined,
                color: Colors.black,
                size: 24.0,
              ),
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            labelColor: AppColors.greenText,
            labelPadding:
                EdgeInsets.only(bottom: 10.0, right: 20.0, left: 20.0),
            unselectedLabelColor: AppColors.grey7,
            indicatorColor: AppColors.greenText,
            tabs: [
              Text(
                'Ăn uống',
              ),
              Text('Công nghệ'),
              Text('Thời trang'),
              Text('Thể thao'),
              Text('Sức khỏe'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            NewsBody(),
            Updating(
              label: 'Chức năng đang được xây dựng...',
              srcImg: 'assets/images/News/update.png',
              onTap: () {},
              textFunction: '',
            ),
            Updating(
              label: 'Chức năng đang được xây dựng...',
              srcImg: 'assets/images/News/update.png',
              onTap: () {},
              textFunction: '',
            ),
            Updating(
              label: 'Chức năng đang được xây dựng...',
              srcImg: 'assets/images/News/update.png',
              onTap: () {},
              textFunction: '',
            ),
            Updating(
              label: 'Chức năng đang được xây dựng...',
              srcImg: 'assets/images/News/update.png',
              onTap: () {},
              textFunction: '',
            ),
          ],
        ),
      ),
    );
  }
}
