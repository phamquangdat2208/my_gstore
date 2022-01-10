class SearchProductConst {
  static const double paddingHorizontal = 16.0;
  static const int sizeMarkerMedium = 90;
  static const int sizeMarkerNormal = 80;
  static const int sizeMarkerBig = 110;
  static const int sizeMarkerBiggest = 130;
  static const double highItemDisplayInfoFilter = 35;

  static const String _path = 'SearchProductConst.';
  static const String textFilter = 'Bộ lọc';
  static const String textFilterCategory = '${_path}textFilterCategory';
  static const String textFilterCost = '${_path}textFilterCost';
  static const String cost = '${_path}cost';
  static const String to = '${_path}to';
  static const String textFillSpace = '${_path}textFillSpace';
  static const String notEnoughMoneyToSearch = '${_path}notEnoughMoneyToSearch';
  static const String typeYourShop = '${_path}typeYourShop';
  static const String typeProductAndClickSearch =
      '${_path}typeProductAndClickSearch';
  static const String tellYourWant = '${_path}tellYourWant';
  static const String endToListen = '${_path}endToListen';
  static const String reCheck = '${_path}reCheck';
  static const String listening = '${_path}listening';
  static const String searchProduct = '${_path}searchProduct';
  static const String noDataCurrent =
      'Không có sản phẩm ở gần bạn, bạn có muốn tìm kiếm trên toàn hệ thống không?';

  static String customMapStyle = '''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]''';
}