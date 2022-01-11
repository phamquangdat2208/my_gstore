import 'package:flutter/material.dart';

const titles = ['Thông tin', 'Chỉ đường', 'Đánh giá'];

class DemoPageViewTitle extends StatelessWidget {
  final Function(int index) onChangeTab;
  final int currentIndex;

  const DemoPageViewTitle(
      {Key? key, required this.currentIndex, required this.onChangeTab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgets = [];
    for (int i = 0; i < titles.length; i++) {
      _widgets.add(_item(titles[i], i));
    }
    return Container(
      width: double.infinity,
      height: 50,
      color: Colors.white,
      child: Row(
        children: _widgets,
      ),
    );
  }

  Widget _item(String text, int index) {
    return Expanded(
        child: InkWell(
      onTap: () {
        onChangeTab(index);
      },
      child: Container(
        padding: EdgeInsets.only(left: 5,right: 5),
        decoration: const BoxDecoration(
            border: Border( bottom: BorderSide(color: Colors.green) ,)
        ),
        height: 50,
        child: Center(
          child: Text(
            text,
            style:
                TextStyle(color: currentIndex == index ? Colors.green : Colors.grey),
          ),
        ),
      ),
    ));
  }
}
