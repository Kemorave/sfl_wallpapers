import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

extension PositionExtension on Position {
  LatLng cordinates() => LatLng(latitude, longitude);
}
