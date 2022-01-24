import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_gstore/common/constants/search_product_constants.dart';
import 'package:my_gstore/common/model/marker_model.dart';
import 'package:my_gstore/common/network/app_client.dart';
import 'package:my_gstore/common/network/configs.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/presentation/journey/feature/screens/gshop%20map%20screen/cubit/map_search_gshop_cubit.dart';
import 'package:my_gstore/presentation/journey/feature/screens/gshop%20map%20screen/widget/listview_gshop_map_screen.dart';

import '../../../../injector_container.dart';

class MapSearchGShopScreen extends StatefulWidget {
  const MapSearchGShopScreen({Key? key}) : super(key: key);

  @override
  _MapSearchGShopScreenState createState() => _MapSearchGShopScreenState();
}

class _MapSearchGShopScreenState extends State<MapSearchGShopScreen> {
  late CameraPosition _initialLocation;
  final _controller = Completer();
  late LatLng _currentLocation;
  int _helperCreateIdMarker = 1;
  ScrollController scrollController = ScrollController();
  final MapGShopScreenCubit _mapGShopScreenCubit =
      injector<MapGShopScreenCubit>();
  Set<Marker> _markers = {};
  bool _enableContinueLoadMore = true;
  @override
  void initState() {
    _mapGShopScreenCubit.getDataLoadInMap();
    final position = injector<AppClient>().header;
    _currentLocation = LatLng(position?.lat ?? Configurations.latGstore,
        position?.lng ?? Configurations.lngGstore);
    _initialLocation = CameraPosition(
      zoom: 12,
      target: _currentLocation,
    );
    _initData();
    super.initState();
    scrollController.addListener(_scrollListener);
  }
  void _scrollListener() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (_enableContinueLoadMore) {
          _enableContinueLoadMore = false;
          _mapGShopScreenCubit.getMoreLoadData();
        }
      }

  }
  void _initData() async {
    final markerData = await _mapGShopScreenCubit.getDataMarkerInMap(
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
    _mapGShopScreenCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColors.white,
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
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
        Positioned(
          top: 20,
          left: 20,
          child: SafeArea(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
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
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    color: AppColors.grey6,
                  )),
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: 20,
          child: SafeArea(
            child: GestureDetector(
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
                child: Icon(
                  Icons.my_location,
                  color: AppColors.grey7,
                ),
              ),
            ),
          ),
        ),
        Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: BlocBuilder<MapGShopScreenCubit, MapGShopScreenState>(
              bloc: _mapGShopScreenCubit,
              buildWhen: (_,state){
                return state is MapGShopScreenGettingDataState||
                state is MapGShopScreenGotDataState;
              },
              builder: (_, state) {
                if (state is MapGShopScreenGettingDataState) {
                  return SizedBox();
                }
                if (state is MapGShopScreenGotDataState &&
                    (state.gshop?.isNotEmpty ?? false)) {
                  if (!state.isLastData) {
                    _enableContinueLoadMore = true;
                  }
                  return ListViewDisplayGShopMapScreen(
                    scrollController: scrollController,
                    information: state.gshop,
                  );
                }
                if (state is MapGShopScreenLoadingMoreState) {
                  return CircularProgressIndicator(color: AppColors.grey5,);
                }
                return Container(
                  child: Text('loi'),
                  color: AppColors.red,
                );
              },
            )
        ),

      ],
    );
  }
}
