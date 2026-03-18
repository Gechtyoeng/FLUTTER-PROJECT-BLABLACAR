import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:blabla/ui/states/ride_preference_state.dart';
import 'package:flutter/widgets.dart';

enum Status { loading, error, success }

class HomeViewModel extends ChangeNotifier {
  final RidePreferenceState rideState;

  Status status = Status.loading;
  List<RidePreference> get ridePreference => rideState.history;
  RidePreference? get currentRide => rideState.currentRide;

  HomeViewModel({required this.rideState}) {
    rideState.addListener(notifyListeners); //listen to state change
    _init();
  }

  @override
  void dispose() {
    rideState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    status = Status.loading;
    notifyListeners();
    try {
      await rideState.loadHistory(); //load ride preference
      status = Status.success;
    } catch (e) {
      status = Status.error;
    }
    notifyListeners();
  }

  //hanlde change ride when search
  void onRidePreferenceSearch(RidePreference ride) {
    //Update the global state
    rideState.changeRide(ride);
  }
}
