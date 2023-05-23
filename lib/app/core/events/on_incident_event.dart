import '../../data/model/incident_model.dart';
import 'event_base.dart';

class OnIncidentEvent extends EventBase<IncidentModel> {
  OnIncidentEvent({super.data, super.tag});
}
