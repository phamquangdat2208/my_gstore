import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_gstore/common/constants/image_constant.dart';
import 'package:my_gstore/common/network/configs.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/presentation/journey/feature/screens/Home/component/filter_screen_bottom_sheet.dart';
import 'package:my_gstore/presentation/journey/feature/screens/Home/component/home_map.dart';

import 'Map Search Screen/map_search_screen.dart';


class MapSearchScreen extends StatefulWidget {
  const MapSearchScreen({Key? key}) : super(key: key);
  @override
  _MapSearchScreenState createState() => _MapSearchScreenState();
}

class _MapSearchScreenState extends State<MapSearchScreen> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 1.5 / 2),
        child: AppBar(
          automaticallyImplyLeading: false,
          leading: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    margin: EdgeInsets.only(left: 15),
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.grey7,
                            blurRadius: 6,
                            offset: Offset(1, 1), // Shadow position
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Icon(Icons.keyboard_arrow_left,color: AppColors.grey6,)),
              ),
            ],
          ),
          flexibleSpace: Container(
          child: MapSearchCityScreen(),
          ),
          title: Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            decoration: new BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.grey7,
                    blurRadius: 6,
                    offset: Offset(1, 1), // Shadow position
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: AppColors.grey8,
                  size: 17,
                ),
                SizedBox(width: 10),
                Text(
                  "Bạn muốn tìm cái giề",
                  style: TextStyle(color: AppColors.grey8, fontSize: 15),
                ),
              ],
            ),
          ),
          actions: [
            InkWell(
              onTap: onFilterPress,
              child: Container(
                margin: EdgeInsets.only(right: 15),
                padding: EdgeInsets.all(10),
                width: 40,
                decoration: new BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.grey7,
                      blurRadius: 6,
                      offset: Offset(1, 1), // Shadow position
                    ),
                  ],
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(Icons.sort,color: AppColors.grey6,)),
              ),
          ],
        ),
      ),
    );
  }
  void onFilterPress() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        context: context,
isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
              heightFactor: 0.85,
              child: FilterScreenSelect());
        });
  }
}
