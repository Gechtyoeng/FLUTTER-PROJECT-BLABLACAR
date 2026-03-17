import 'package:blabla/data/repositories/locations/location_repository.dart';
import 'package:blabla/data/repositories/locations/location_repository_mock.dart';
import 'package:blabla/data/repositories/ride_preferences/ride_preference_repository.dart';
import 'package:blabla/data/repositories/ride_preferences/ride_preference_repository_mock.dart';
import 'package:blabla/data/repositories/rides/ride_repository.dart';
import 'package:blabla/data/repositories/rides/ride_repository_mock.dart';
import 'package:blabla/main_common.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

/// Configure provider dependencies
List<InheritedProvider> get devProviders {
  final locationRepository = LocationRepositoryMock();
  final rideRepository = RideRepositoryMock();
  final ridePreferenceRepository = RidePreferenceRepositoryMock();

  return [
    //Inject the location repo
    Provider<LocationRepository>(create: (_) => locationRepository),
    //Inject ride repo
    Provider<RideRepository>(create: (_) => rideRepository),
    //Inject ride preference repo
    Provider<RidePreferenceRepository>(create: (_) => ridePreferenceRepository)

  ];
}
void main() {
  runApp(BlaBlaApp(providers: devProviders));
}

