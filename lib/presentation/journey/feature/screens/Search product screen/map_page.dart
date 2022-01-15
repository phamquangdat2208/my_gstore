import 'package:flutter/material.dart';
import 'package:my_gstore/presentation/journey/feature/screens/Search%20product%20screen/panel_product_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'map_widget.dart';

class MapPageScreen extends StatefulWidget {
  const MapPageScreen({Key? key}) : super(key: key);
  @override
  _MapPageScreenState createState() => _MapPageScreenState();
}

class _MapPageScreenState extends State<MapPageScreen> {
  final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    final panelHightClosed = MediaQuery.of(context).size.height * 0.4;
    final panelHightOpened = MediaQuery.of(context).size.height * 0.85;
    return Scaffold(
      backgroundColor:Colors.white,
      body: SlidingUpPanel(
        color: Colors.white,
        controller: panelController,
        maxHeight: panelHightOpened,
        minHeight: panelHightClosed,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        body: MapSearchScreen(),
        panelBuilder: (controller) => ProductPanel(
          controller: controller,
          panelController: panelController,
        ),
      ),
    );
  }
}
