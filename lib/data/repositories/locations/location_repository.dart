import 'package:blabla/model/ride/locations.dart';

abstract class LocationRepository {
  Future<List<Location>> loadLocations();
  Future<List<Location>> filterLocation(String search);
}
