import 'package:blabla/data/dummy_data.dart';
import 'package:blabla/data/repositories/rides/ride_repository.dart';
import 'package:blabla/model/ride/ride.dart';


class RideRepositoryMock extends RideRepository {
  @override
  Future<List<Ride>> loadRide() async {
    await Future.delayed(Duration(seconds: 1));
    return fakeRides;
  }
}
