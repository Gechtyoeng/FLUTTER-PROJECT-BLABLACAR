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
}
