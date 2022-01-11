import 'package:flutter/material.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
class FilterPriceBox extends StatefulWidget {
  const FilterPriceBox({Key? key}) : super(key: key);
  @override
  _FilterPriceBoxState createState() => _FilterPriceBoxState();
}

class _FilterPriceBoxState extends State<FilterPriceBox> {
  final items=['0 - 100.000đ','100.000đ - 500.000đ','500.000đ - 1.000.000đ','1.000.000 - 3.000.000đ','3.000.000đ - 5.000.000đ','5.000.000đ - 10.000.000đ','Hơn 10.000.000đ'];
  String? value;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      dropdownColor: AppColors.white,
      alignment: Alignment.bottomCenter,
      decoration: InputDecoration.collapsed(hintText: ''),
      value: value,
      iconSize: 35,
      items: items.map(buildMenuItem).toList(),
      onChanged: (value)=>this.value = value,
      onSaved: (newvalue){
        setState(() {
          value= newvalue;
        });
      },
      isExpanded: true,
    );
  }
  DropdownMenuItem<String> buildMenuItem(String item){
    return DropdownMenuItem(
        value: item,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15,top:10),
              child: Text(
                item,
                style: TextStyle(color: AppColors.black),
              ),
            ),
          ],
        ));
  }
}
