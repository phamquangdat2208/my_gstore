import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_event.dart';
import 'package:my_gstore/common/bloc/snackbar_bloc/snackbar_state.dart';
import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/common/constants/search_product_constants.dart';
import 'package:my_gstore/common/global_app_cache/global_app_catch.dart';
import 'package:my_gstore/common/model/app_position.dart';
import 'package:my_gstore/common/network/configs.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/ultils/common_util.dart';
import 'package:my_gstore/common/ultils/screen_utils.dart';

import '../../../../../injector_container.dart';

class DetailProductDirection extends StatefulWidget {
  final LatLng? latLng;
  final int indexSelected;

  DetailProductDirection({
    Key? key,
    required this.latLng,
    required this.indexSelected,
  }) : super(key: key);

  @override
  _DetailProductDirectionState createState() => _DetailProductDirectionState();
}

class _DetailProductDirectionState extends State<DetailProductDirection> {
  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];
  late CameraPosition _initialLocation;
  late LatLng _currentLocation;
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  bool _firstInitData = true;
  Map<PolylineId, Polyline> polylines = {};

  Future _createPolylines(AppPosition? start, AppPosition destination) async {
    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Configurations.mapApiKey, // Google Maps API Key
      PointLatLng(start?.latitude ?? 0, start?.longitude ?? 0),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: AppColors.primaryColor,
      points: polylineCoordinates,
      width: 6,
    );
    polylines[id] = polyline;
  }

  void _setup() async {
    if (widget.latLng!.latitude == 0) {
      return;
    }
    AppPosition? position = injector<GlobalAppCache>().gspPosition;
    _currentLocation =
        LatLng(Configurations.latGstore ?? 0, Configurations.lngGstore ?? 0);
    _initialLocation = CameraPosition(zoom: 13.5, target: _currentLocation);
    final data = await createMarker();
    _markers.add(data);
    AppPosition targetPosition = AppPosition(
        latitude: widget.latLng!.latitude, longitude: widget.latLng!.longitude);
    await _createPolylines(position, targetPosition);
    setState(() {});
  }

  void _openMap() async {
    try {
      await CommonUtils.openMap(
          widget.latLng!.latitude, widget.latLng!.longitude);
    } catch (e) {
      injector<SnackBarBloc>().add(
          ShowSnackbarEvent(type: SnackBarType.error, content: e.toString()));
    }
  }

  @override
  void didUpdateWidget(covariant DetailProductDirection oldWidget) {
    if (widget.indexSelected == 1 && _firstInitData) {
      _firstInitData = false;
      _setup();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return widget.latLng?.latitude == null
        ? SizedBox()
        : Container(
            color: Colors.white,
            width: double.infinity,
            height: GScreenUtil.screenWidthDp * 1.2,
            child: Stack(
              children: [
                GoogleMap(
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  polylines: Set<Polyline>.of(polylines.values),
                  compassEnabled: true,
                  onTap: (latlong) {
                    _openMap();
                  },
                  mapToolbarEnabled: false,
                  zoomControlsEnabled: false,
                  markers: _markers,
                  initialCameraPosition: _initialLocation,
                  onMapCreated: (GoogleMapController controller) {
                    controller.setMapStyle(SearchProductConst.customMapStyle);
                    _controller.complete(controller);
                  },
                ),
                InkWell(
                  onTap: _openMap,
                  child: Container(
                    width: double.infinity,
                    height: GScreenUtil.screenWidthDp * 1.2,
                  ),
                ),
              ],
            ),
          );
  }

  Future<Marker> createMarker() async {
    Uint8List? markerIcon = await CommonUtils.getBytesFromAsset(
        IconConst.targetLocation, SearchProductConst.sizeMarkerMedium);
    return Marker(
      icon: BitmapDescriptor.fromBytes(markerIcon!),
      position: LatLng(widget.latLng!.latitude, widget.latLng!.longitude),
      markerId: MarkerId('targetLocation'),
    );
  }
}
