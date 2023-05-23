// ignore_for_file: must_be_immutable

import 'package:sfl/app/core/extentions/incident_model_extention_extension.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../locator.dart';
import '../../data/model/incident_model.dart';

class IncidentMarker extends Marker {
  IncidentModel incident;

  IncidentMarker({required this.incident, Function? infoWindowOnTap})
      : super(
          markerId: MarkerId(incident.id),
          position: LatLng(
              double.parse(incident.lat != null ? incident.lat! : "27.510952"),
              double.parse(
                  incident.long != null ? incident.long! : "41.703672")),
          infoWindow: InfoWindow(
            onTap: () {
              if (infoWindowOnTap != null) infoWindowOnTap();
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => InidentDetailsScreen(
              //           incidentId: e?.id,
              //         )));
            },
            title: incident.localizedTitle(),
            snippet:
                '${incident.localizedStatusName()} - ${language().strings.pressToShowMore}',
          ),
          icon: incident.markerIcon(),
        );
}
