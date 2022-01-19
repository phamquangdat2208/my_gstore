import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_gstore/common/constants/home_constant.dart';
import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/common/constants/search_product_constants.dart';
import 'package:my_gstore/common/global_app_cache/global_app_catch.dart';
import 'package:my_gstore/common/model/location_in_map_model.dart';
import 'package:my_gstore/common/model/marker_model.dart';
import 'package:my_gstore/common/navigation/route_names.dart';
import 'package:my_gstore/common/network/app_client.dart';
import 'package:my_gstore/common/network/configs.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/presentation/journey/feature/screens/Search%20product%20screen/cubit/map_search_screen_cubit.dart';

import '../../../../../injector_container.dart';
import '../../../../../routes.dart';

class HomeMapComponent extends StatefulWidget {
  const HomeMapComponent({Key? key}) : super(key: key);
  @override
  _HomeMapComponentState createState() => _HomeMapComponentState();
}

class _HomeMapComponentState extends State<HomeMapComponent> {
  final MapSearchProductScreenCubit _mapSearchScreenCubit = injector<MapSearchProductScreenCubit>();
  late CameraPosition _initialLocation;
  final _controller = Completer();
  late LatLng _currentLocation;
  int _helperCreateIdMarker = 1;
  Set<Marker> _markers = {};

  @override
  void initState() {
    final position = injector<AppClient>().header;
    _currentLocation = LatLng(position?.lat?? Configurations.lngGstore,position?.lng??Configurations.lngGstore);
    _initialLocation = CameraPosition(
      zoom: 12,
      target: _currentLocation,
    );
    _initData();
    super.initState();
  }
  void _initData() async {
    final markerData = await _mapSearchScreenCubit.getDataMarkerInMap(
      lat: Configurations.latGstore,
      lng: Configurations.lngGstore,
    );
    _mapDataToListMarker(markerData);
  }
  Future _startSearch() async {
    await Routes.instance.navigateTo(RouteName.searchProductScreen);
  }

  void _mapDataToListMarker(List<MarkerModel>? locations) {
    locations?.forEach((obj) {
      _markers.add(Marker(
          icon: obj.dataIconMarker ?? BitmapDescriptor.defaultMarker,
          position: LatLng(obj.latitude ?? 0, obj.longitude ?? 0),
          markerId: MarkerId('${++_helperCreateIdMarker}'),
          onTap: () { }));
    });
    setState(() {});
  }
  void dispose() {
    _mapSearchScreenCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
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
                          markers: _markers,
                          onCameraMove: (newPosition) {},
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _startSearch();
                      },
                      child: const SizedBox(
                        width: double.infinity,
                        height: 200,
                      ),
                    ),
                    Positioned.fill(
                      left: 20,
                      right: 20,
                      top: 20,
                      bottom: 20,
                      child: InkWell(
                        onTap: () {
                          _startSearch();
                        },
                      ),
                    )
                  ],
                ),
              ),
              Positioned.fill(
                  bottom: 2,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        _startSearch();
                      },
                      child: Container(
                        width: 165.0,
                        height: 32.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.grey300,
                                offset: const Offset(0, 1),
                                // changes position of shadow
                              ),
                            ],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(24.0))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Tìm quanh tôi',
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(width: 10.67),
                            SvgPicture.asset(IconConst.iconRight,
                                width: 7.0, height: 14.0),
                          ],
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
