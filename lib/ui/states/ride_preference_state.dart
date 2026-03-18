import 'package:blabla/data/repositories/ride_preferences/ride_preference_repository.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:flutter/widgets.dart';

class RidePreferenceState extends ChangeNotifier {
  RidePreferenceRepository preferenceRepository;
  RidePreferenceState(this.preferenceRepository);

  RidePreference? _currentRidePreference;
  RidePreference? get currentRide => _currentRidePreference;

  List<RidePreference> _history = [];
  List<RidePreference> get history => _history;

  void changeRide(RidePreference newRide) {
    _currentRidePreference = newRide;

    _history.removeWhere((item) => item == newRide);
    _history.insert(0, newRide); // insert ride to history

    notifyListeners();
  }

  Future<void> loadHistory() async {
    _history = await preferenceRepository.loadRidePrederence();
    notifyListeners();
  }
}
