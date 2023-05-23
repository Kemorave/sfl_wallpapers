import 'package:google_maps_flutter/google_maps_flutter.dart';

extension LatLangExtension on LatLng {
  LatLng withLess({double? lat, double? lang}) {
    return LatLng(latitude - (lat ?? 0), longitude - (lang ?? 0));
  }

  LatLng withMore({double? lat, double? lang}) {
    return LatLng(latitude + (lat ?? 0), longitude + (lang ?? 0));
  }
}
