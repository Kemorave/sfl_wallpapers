import 'package:sfl/locator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'location_pick_widget_page.dart';

Future<LatLng?>? openLocationPicker(LatLng init, LatLng camPosition,
    {List<Marker>? marks,
    List<Polygon>? polygons,
    List<LatLng>? restrictedArea,
    String? outOfBoundsMessage}) {
  return navigation().dialog<LatLng>(LocationPickWidgetPage(
    init: init,
    marks: marks?.toSet(),
    camPosition: camPosition,
    polygons: polygons?.toSet(),
    outOfBoundsMessage: outOfBoundsMessage,
    restrictedArea: restrictedArea,
  ));
}
