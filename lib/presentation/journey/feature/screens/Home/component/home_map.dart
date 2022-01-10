import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_gstore/common/constants/home_constant.dart';
import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/common/constants/search_product_constants.dart';
import 'package:my_gstore/common/global_app_cache/global_app_catch.dart';
import 'package:my_gstore/common/model/location_in_map_model.dart';
import 'package:my_gstore/common/theme/theme_color.dart';

import '../../../../../injector_container.dart';

class HomeMapComponent extends StatefulWidget {
  const HomeMapComponent({Key? key}) : super(key: key);

  @override
  _HomeMapComponentState createState() => _HomeMapComponentState();
}

class _HomeMapComponentState extends State<HomeMapComponent> {
  late CameraPosition _initialLocation;
  final _controller = Completer();
  late LatLng _currentLocation;
  int _helperCreateIdMarker = 1;
  @override
  void initState() {
    final position = injector<GlobalAppCache>().gspPosition;
    _currentLocation =
        LatLng(position?.latitude ?? 0, position?.longitude ?? 0);
    _initialLocation = CameraPosition(
      zoom: 12,
      target: _currentLocation,
    );
    super.initState();
  }

  Set<Marker> _mapDataToListMarker(List<ShopInMapModel> locations) {
    Set<Marker> _markers = {};
    locations.forEach((obj) {
      _markers.add(Marker(
          icon: obj.dataIconMarker ?? BitmapDescriptor.defaultMarker,
          position: LatLng(obj.latitude ?? 0, obj.longitude ?? 0),
          markerId: MarkerId('${++_helperCreateIdMarker}'),
          onTap: () {}));
    });
    return _markers;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: GoogleMap(
                      myLocationEnabled: true,
                      compassEnabled: true,
                      onTap: (latlong) {},
                      mapToolbarEnabled: false,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      initialCameraPosition: _initialLocation,
                      onMapCreated: (GoogleMapController controller) {
                        controller
                            .setMapStyle(SearchProductConst.customMapStyle);
                        _controller.complete(controller);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  )
                ],
              ),
              Positioned.fill(
                bottom: 0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: 165.0,
                      height: 32.0,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.grey300, offset: Offset(0, 1))
                          ],
                          borderRadius:
                          BorderRadius.all(Radius.circular(24.0))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            HomeConstant.findNearMe,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Image.asset(
                            IconConst.iconRight,
                            height: 20.0,
                            color: AppColors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}