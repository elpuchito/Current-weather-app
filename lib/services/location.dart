import 'package:geolocator/geolocator.dart';

class Location {
  Location({this.latitud, this.longitud});
  double latitud;
  double longitud;
  final geo = Geolocator();

  Future<void> getCurrentLocation() async {
    try {
      Position position =
          await geo.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      latitud = position.latitude;
      longitud = position.longitude;
      print(position);
    } catch (e) {
      print(e);
    }
  }
}
