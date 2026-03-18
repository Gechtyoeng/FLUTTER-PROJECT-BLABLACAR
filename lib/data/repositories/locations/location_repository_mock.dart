import 'package:blabla/data/dummy_data.dart';
import 'package:blabla/data/repositories/locations/location_repository.dart';
import 'package:blabla/model/ride/locations.dart';

class LocationRepositoryMock extends LocationRepository {
  //Get all fake location
  @override
  Future<List<Location>> loadLocations() async {
    await Future.delayed(const Duration(seconds: 1));
    return fakeLocations;
  }

  @override
  Future<List<Location>> filterLocation(String search) async {
    await Future.delayed(const Duration(seconds: 1));

    if (search.length < 2) return [];

    return fakeLocations
        .where((location) => location.name.toUpperCase().contains(search.toUpperCase()) || location.country.name.toUpperCase().contains(search.toUpperCase()))
        .toList();
  }
}
