
import 'package:geolocator/geolocator.dart';

class AppPosition {
  double latitude = 0;
  double longitude = 0;

  AppPosition({this.latitude = 0, this.longitude = 0});

  AppPosition.fromJson(Map<String, dynamic> data) {
    latitude = data['latitude'];
    longitude = data['longitude'];
  }

  AppPosition.fromPosition(Position? position) {
    latitude = position?.latitude??0;
    longitude = position?.longitude??0;
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}