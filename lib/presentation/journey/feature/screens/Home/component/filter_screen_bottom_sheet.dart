import 'package:flutter/material.dart';
import 'package:my_gstore/common/customs/custom_gesturedetactor.dart';

import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';

import 'filter_price_selectbox.dart';
import 'label_checkbox_checkbox.dart';


class FilterScreenSelect extends StatefulWidget {
  const FilterScreenSelect({Key? key}) : super(key: key);

  @override
  _FilterScreenSelectState createState() => _FilterScreenSelectState();
}

class _FilterScreenSelectState extends State<FilterScreenSelect> {
 bool isSelected1=false,isSelected2=false,isSelected3=false,isSelected4=false,isSelected5=false,isSelected6=false,isSelected7 =false;
  double height = 10.0;

  final items = [
    '0 - 100.000đ',
    '100.000đ - 500.000đ',
    '500.000đ - 1.000.000đ',
    '1.000.000 - 3.000.000đ',
    '3.000.000đ - 5.000.000đ',
    '5.000.000đ - 10.000.000đ',
    'Hơn 10.000.000đ'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomGestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close,size: 20,)),
                    Text("Bộ lọc",
                        style: AppTextTheme.mediumBlack.copyWith(fontWeight: FontWeight.w600)),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        'Reset',
                        style:AppTextTheme.normalBlue,
                      ),
                    ),
                  ],
                ),
              ),
             SizedBox(height: 20),
              Row(
                children: [
                  Text('Lọc theo khoảng cách'),
                  Spacer(),
                  Text('Bỏ lọc'),
                ],
              ),
              Slider(
                  value: height.toDouble(),
                  min: 0.0,
                  max: 25.0,
                  divisions: 25,
                  thumbColor: AppColors.green,
                  activeColor: AppColors.green,
                  inactiveColor: AppColors.grey6,
                  label: '${height.round().toString()}km',
                  onChanged: (double newvalue) {
                    setState(() {
                      height = newvalue;
                    });
                  }),
              Text('Lọc theo giá'),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey5, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: FilterPriceBox(),
                ),
              ),

              Text('Lọc theo danh mục'),
              // ListView.builder(itemBuilder: itemBuilder),
              LabeledCheckBoxComponent(
                label: 'Thời trang',
                onChanged: (value) {
                  setState(() {
                    isSelected1 = value;
                  });
                },
                quantity: '2',
                srcImg: 'assets/icons/charity_share.png',
                value: isSelected1,
              ),
              LabeledCheckBoxComponent(
                label: 'Máy tính',
                onChanged: (value) {
                  setState(() {
                    isSelected2 = value;
                  });
                },
                quantity: '0',
                srcImg: 'assets/icons/charity_share.png',
                value: isSelected2,
              ),
              LabeledCheckBoxComponent(
                label: 'Gym ',
                onChanged: (value) {
                  setState(() {
                    isSelected3=value;
                  });
                },
                quantity: '20',
                srcImg: 'assets/icons/charity_share.png',
                value: isSelected3,
              ),
              LabeledCheckBoxComponent(
                label: 'Cho thuê xe ',
                onChanged: (value) {
                  setState(() {
                    isSelected4 = value;
                  });
                },
                quantity: '110',
                srcImg: 'assets/icons/charity_share.png',
                value: isSelected4,
              ),
              LabeledCheckBoxComponent(
                label: 'Book ',
                onChanged: (value) {
                  setState(() {
                    isSelected5 = value;
                  });
                },
                quantity: '45',
                srcImg: 'assets/icons/charity_share.png',
                value: isSelected5,
              ),
              LabeledCheckBoxComponent(
                label: 'Đồ uống ',
                onChanged: (value) {
                  setState(() {
                    isSelected6 = value;
                  });
                },
                quantity: '49',
                srcImg: 'assets/icons/charity_share.png',
                value: isSelected6,
              ),
              LabeledCheckBoxComponent(
                label: 'Đồ ăn',
                onChanged: (value) {
                  setState(() {
                    isSelected7 = value ;
                  });
                },
                quantity: '27',
                srcImg: 'assets/icons/charity_share.png',
                value: isSelected7,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
