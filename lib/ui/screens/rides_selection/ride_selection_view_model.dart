import 'package:blabla/data/repositories/rides/ride_repository.dart';
import 'package:blabla/model/ride/ride.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:blabla/ui/states/ride_preference_state.dart';
import 'package:flutter/material.dart';

enum RideSelectionStatus { loading, success, error }

class RideSelectionViewModel extends ChangeNotifier {
  final RidePreferenceState rideState; //get current ride preference
  final RideRepository rideRepo; //to fetch list of rides

  RideSelectionStatus status = RideSelectionStatus.loading;

  List<Ride> _rides = [];
  List<Ride> get rides => _rides;
  RidePreference? get currentPreference => rideState.currentRide;

  RideSelectionViewModel({required this.rideRepo, required this.rideState}) {
    rideState.addListener(_onRidePreferenceChanged);
    _loadRides();
  }

  @override
  void dispose() {
    rideState.removeListener(_onRidePreferenceChanged);
    super.dispose();
  }

  void _onRidePreferenceChanged() {
    _loadRides();
  }

  Future<void> _loadRides() async {
    if (currentPreference == null) return;

    status = RideSelectionStatus.loading;
    notifyListeners();

    try {
      _rides = await rideRepo.getRidesFor(currentPreference!);
      status = RideSelectionStatus.success;
    } catch (e) {
      status = RideSelectionStatus.error;
    }

    notifyListeners();
  }

  void updateRidePreference(RidePreference newPreference) {
    rideState.changeRide(newPreference);
  }
}
