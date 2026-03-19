import 'package:blabla/model/ride/ride.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';

abstract class RideRepository {
  Future<List<Ride>> loadRide();
  Future<List<Ride>> getRidesFor(RidePreference preferences);
}
