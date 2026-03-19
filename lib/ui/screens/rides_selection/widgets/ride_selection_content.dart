import 'package:blabla/model/ride/ride.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:blabla/ui/screens/rides_selection/ride_selection_view_model.dart';
import 'package:blabla/ui/screens/rides_selection/widgets/ride_preference_modal.dart';
import 'package:blabla/ui/screens/rides_selection/widgets/rides_selection_header.dart';
import 'package:blabla/ui/screens/rides_selection/widgets/rides_selection_tile.dart';
import 'package:blabla/ui/theme/theme.dart';
import 'package:blabla/utils/animations_util.dart';
import 'package:flutter/material.dart';

class RideSelectionContent extends StatelessWidget {
  final RideSelectionViewModel rideVM;
  const RideSelectionContent({super.key, required this.rideVM});

  void _onBackTap(BuildContext context) {
    Navigator.pop(context);
  }

  void onFilterPressed() {
    // TODO
  }

  void onRideSelected(Ride ride) {
    // Later
  }

  void _onPreferencePressed(BuildContext context) async {
    // 1 - Navigate to the rides preference picker by adding current ride preference
    final RidePreference? newPreference = await Navigator.of(
      context,
    ).push<RidePreference>(AnimationUtils.createRightToLeftRoute(RidePreferenceModal(initialPreference: rideVM.currentPreference)));

    if (newPreference != null) {
      // 2 - Ask the service to update the current preference
      rideVM.updateRidePreference(newPreference);

      // 3 -   Update the widget state  - TODO Improve this with proper state managagement
    }
  }

  @override
  Widget build(BuildContext context) {
    if (rideVM.status == RideSelectionStatus.loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (rideVM.status == RideSelectionStatus.error) {
      return const Scaffold(body: Center(child: Text("Something went wrong")));
    }

    // return Consumer<RidePreferenceState>(
    //   builder: (context, rideState, _) {
    //     final selectedRidePreference = rideState.currentRide!;
    //     final matchingRides = RidesService.getRidesFor(selectedRidePreference);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: BlaSpacings.m, right: BlaSpacings.m, top: BlaSpacings.s),
        child: Column(
          children: [
            RideSelectionHeader(
              ridePreference: rideVM.currentPreference!,
              onBackPressed: () => _onBackTap(context),
              onFilterPressed: onFilterPressed,
              onPreferencePressed: () => _onPreferencePressed(context),
            ),

            SizedBox(height: 100),

            Expanded(
              child: ListView.builder(
                itemCount: rideVM.rides.length,
                itemBuilder: (ctx, index) => RideSelectionTile(ride: rideVM.rides[index], onPressed: () => onRideSelected(rideVM.rides[index])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
