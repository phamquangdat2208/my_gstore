import 'package:flutter/material.dart';

import 'news_body_contents.dart';

class DetailedNews extends StatelessWidget {
  final Food food;
  const DetailedNews({Key? key, required this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(250.0),
        child: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.keyboard_arrow_left,
                color: Colors.white,
                size: 30,
              )),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.share, color: Colors.white),
            ),
            SizedBox(
              width: 10.0,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_horiz, color: Colors.white),
            ),
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(food.image),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4), BlendMode.darken)),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '4 món cùng tên nhưng khác cách chế biến ở Hà Nội và TP.HCM',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  '11:32 30/9/2020  ',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Dù có bản chất giống nhau, một số món ở hai thành phố vẫn có sự khác biệt về hương vị, cách làm. Điều này đem đến trải nghiệm ẩm thực thú vị cho khách du lịch.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  food.title,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  food.description,
                  style: TextStyle(fontSize: 14),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
