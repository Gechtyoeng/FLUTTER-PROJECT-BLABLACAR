import 'package:blabla/data/dummy_data.dart';
import 'package:blabla/data/repositories/rides/ride_repository.dart';
import 'package:blabla/model/ride/ride.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';

class RideRepositoryMock extends RideRepository {
  @override
  Future<List<Ride>> loadRide() async {
    await Future.delayed(Duration(seconds: 1));
    return fakeRides;
  }

  @override
  Future<List<Ride>> getRidesFor(RidePreference preferences) async {
    await Future.delayed(Duration(seconds: 1));
    return fakeRides
        .where((ride) => ride.departureLocation == preferences.departure && ride.arrivalLocation == preferences.arrival && ride.availableSeats >= preferences.requestedSeats)
        .toList();
  }
}
