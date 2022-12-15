// ignore: constant_identifier_names
import 'package:places/handlers/location_handler.dart';

// ignore: constant_identifier_names
const GOOGLE_MAPS_API_KEY = 'AIzaSyDt2OHY-Dbr6gMBUTrA1KQfOwj0gW3iqjU';

class GoogleMapsHandler implements LocationHandler {
  @override
  String generateLocationPreviewImage(
      {required double latitude, required double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,&$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Alabel:A%7C$latitude,$longitude&key=$GOOGLE_MAPS_API_KEY';
  }
}
