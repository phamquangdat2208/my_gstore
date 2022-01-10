import 'package:flutter/material.dart';
import 'package:my_gstore/common/theme/theme_color.dart';

import '../../../../routes.dart';


class AllProductScreen extends StatefulWidget {
  final String? url;
  final String? title;
  const AllProductScreen({Key? key,required this.url,required this.title}) : super(key: key);
  @override
  _AllProductScreenState createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(widget?.title??'', style: TextStyle(fontSize: 16, color: AppColors.grey9, fontWeight: FontWeight.w500),),
        actions: [
          IconButton(
              onPressed: () {

              },
              icon: const Icon(Icons.search, color: Colors.black,)),
          IconButton(
              onPressed: () {

              },
              icon: const Icon(Icons.tune, color: Colors.black,)),
        ],
        leading: IconButton(
          onPressed: () {
            Routes.instance.pop();
          },
          icon: const Icon(Icons.keyboard_arrow_left, color: Colors.black,),
        ),
      ),
      body: Column(
        children: [
          // Expanded(
          //   // child: GridView.builder(
          //   //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
          //   //     crossAxisCount: 2,
          //   //   ),
          //   //   scrollDirection: Axis.vertical,
          //   //   itemBuilder: (context, index) =>
          //   //       ItemCardX(item: list[index]),
          //   //   itemCount: list.length,
          //   // ),
          // )
        ],
      ),
    );
  }
}

