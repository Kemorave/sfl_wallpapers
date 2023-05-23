import 'package:sfl/app/core/widgets/photo_gallery_widget/photo_gallery_widget_page.dart';
import 'package:sfl/app/data/model/incident_details_model.dart';
import 'package:sfl/locator.dart';

openIncidentImageGallery(IncidentDetailsModel incident) {
  var images = incident.images.map((e) => e.path ?? '');
  openImageGallery(images);
}

openImageGallery(Iterable<String> images) {
  navigation().dialog(PhotoGalleryWidgetPage(galleryItems: images.toList()));
}
