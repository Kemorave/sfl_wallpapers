import 'package:sfl/app/core/vm.dart';
import 'package:sfl/locator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class LocationPickWidgetPage extends StatefulWidget {
  late GoogleMapController mapController;
  final LatLng init;
  final Set<Marker>? marks;
  final Set<Polygon>? polygons;
  final List<LatLng>? restrictedArea;
  final String? outOfBoundsMessage;

  LatLng? camPosition;
  LocationPickWidgetPage(
      {super.key,
      required this.init,
      this.marks,
      this.polygons,
      this.outOfBoundsMessage,
      this.camPosition,
      this.restrictedArea});
  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  State<LocationPickWidgetPage> createState() => _LocationPickWidgetPageState();
}

bool isAreaWithin(LatLng selectedPosition, List<LatLng> locationPoints) {
  bool c = false;
  int i = 0;
  int j = locationPoints.length - 1;
  for (var point in locationPoints) {
    double latI = point.latitude;
    double lonI = point.longitude;

    double latJ = locationPoints[j].latitude;
    double lonJ = locationPoints[j].longitude;

    if (latI > selectedPosition.latitude != latJ > selectedPosition.latitude &&
        selectedPosition.longitude <
            (lonJ - lonI) * (selectedPosition.latitude - latI) / (latJ - latI) +
                lonI) {
      c = !c;
    }

    j = i++;
  }
  return c;
}

class _LocationPickWidgetPageState extends State<LocationPickWidgetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                clipBehavior: Clip.hardEdge,
                child: GoogleMap(
                  polygons: widget.polygons ?? {},
                  liteModeEnabled: false,
                  circles: {
                    Circle(
                        circleId: const CircleId('value'),
                        center: widget.init,
                        strokeColor: Colors.black,
                        strokeWidth: 2,
                        fillColor: Colors.transparent,
                        radius: 150)
                  },
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: widget.camPosition ?? widget.init,
                    zoom: 17,
                  ),
                  onMapCreated: widget.onMapCreated,
                  mapType: MapType.normal,
                  compassEnabled: true,
                  buildingsEnabled: true,
                  mapToolbarEnabled: true,
                  zoomGesturesEnabled: true,
                  rotateGesturesEnabled: true,
                ),
              ),
              const Center(
                child: AbsorbPointer(
                  child: SizedBox(
                    height: 40,
                    child: Icon(
                      Icons.location_pin,
                      color: Colors.deepOrange,
                      size: 40,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 33),
                  child: ElevatedButton(
                      child: Text(language().strings.selectLocation),
                      onPressed: () async {
                        var visibleRegion =
                            await widget.mapController.getVisibleRegion();
                        var res = LatLng(
                          (visibleRegion.northeast.latitude +
                                  visibleRegion.southwest.latitude) /
                              2,
                          (visibleRegion.northeast.longitude +
                                  visibleRegion.southwest.longitude) /
                              2,
                        );

                        if (widget.restrictedArea != null &&
                            !isAreaWithin(res, widget.restrictedArea!)) {
                          ViewModel.showDialog(language().strings.outOfBounds,
                              widget.outOfBoundsMessage ?? '...');
                          return;
                        }
                        navigation().goBack(result: res);
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
