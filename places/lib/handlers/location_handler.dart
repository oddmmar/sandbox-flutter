import 'package:places/handlers/google_maps_handler.dart';

abstract class LocationHandler {
  factory LocationHandler() => GoogleMapsHandler();
  String generateLocationPreviewImage({
    required double latitude,
    required double longitude,
  });
}
