import 'package:blabla/data/dummy_data.dart';
import 'package:blabla/data/repositories/ride_preferences/ride_preference_repository.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';

class RidePreferenceRepositoryMock extends RidePreferenceRepository {
  @override
  Future<List<RidePreference>> loadRidePrederence() async {
    await Future.delayed(Duration(seconds: 1));
    return fakeRidePrefs;
  }
}
