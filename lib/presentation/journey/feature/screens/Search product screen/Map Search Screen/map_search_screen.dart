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
import 'package:my_gstore/common/ultils/log_util.dart';
import 'package:my_gstore/presentation/journey/feature/screens/Search%20product%20screen/cubit/map_search_screen_cubit.dart';

import '../../../../../injector_container.dart';
import '../../../../../routes.dart';

class MapSearchCityScreen extends StatefulWidget {
  const MapSearchCityScreen({Key? key}) : super(key: key);
  @override
  _MapSearchCityScreenState createState() => _MapSearchCityScreenState();
}

class _MapSearchCityScreenState extends State<MapSearchCityScreen> {
  late CameraPosition _initialLocation;
  final _controller = Completer();
  late LatLng _currentLocation;
  int _helperCreateIdMarker = 1;
  final MapSearchScreenCubit _mapSearchScreenCubit =
      injector<MapSearchScreenCubit>();
  Set<Marker> _markers = {};

  @override
  void initState() {
    final position = injector<AppClient>().header;
    _currentLocation = LatLng(position?.lat ?? Configurations.latGstore,
        position?.lng ?? Configurations.lngGstore);
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

  void _mapDataToListMarker(List<MarkerModel>? locations) {
    locations?.forEach((obj) {
      _markers.add(Marker(
          icon: obj.dataIconMarker ?? BitmapDescriptor.defaultMarker,
          position: LatLng(obj.latitude ?? 0, obj.longitude ?? 0),
          markerId: MarkerId('${++_helperCreateIdMarker}'),
          onTap: () {
            // _onItemMarkerTap(obj);
          }));
    });
    setState(() {});
  }

  @override
  void dispose() {
    _mapSearchScreenCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Container(
        color: AppColors.white,
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
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
              controller.setMapStyle(SearchProductConst.customMapStyle);
              _controller.complete(controller);
            },
            onCameraMove: (newPosition) {},
            markers: _markers,
          ),
        ),
      ),
    );
  }
}
