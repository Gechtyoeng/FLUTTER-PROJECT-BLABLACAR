import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:blabla/ui/screens/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utils/animations_util.dart';
import '../../../theme/theme.dart';
import '../../../widgets/pickers/bla_ride_preference_picker.dart';
import '../../rides_selection/rides_selection_screen.dart';
import '../widgets/home_history_tile.dart';

const String blablaHomeImagePath = 'assets/images/blabla_home.png';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  void _onRidePrefSelected(BuildContext context, RidePreference selectedPreference) async {
    final viewModel = Provider.of<HomeViewModel>(context, listen: false);

    // 1 - Update global state via view model
    viewModel.onRidePreferenceSearch(selectedPreference);

    // 2 - Navigate to the rides screen
    await Navigator.of(context).push(AnimationUtils.createBottomToTopRoute(RidesSelectionScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_buildBackground(), _buildForeground(context)]);
  }

  Widget _buildForeground(BuildContext context) {
    return Column(
      // 1 - THE HEADER
      children: [
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.center,
          child: Text("Your pick of rides at low price", style: BlaTextStyles.heading.copyWith(color: Colors.white)),
        ),
        const SizedBox(height: 100),
        Container(
          margin: EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
          decoration: BoxDecoration(
            color: Colors.white, // White background
            borderRadius: BorderRadius.circular(16),
          ), // Rounded corners
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 2 - THE FORM
              Consumer<HomeViewModel>(
                builder: (context, viewModel, _) =>
                    BlaRidePreferencePicker(initRidePreference: viewModel.currentRide, onRidePreferenceSelected: (ride) => _onRidePrefSelected(context, ride)),
              ),
              SizedBox(height: BlaSpacings.m),
              _buildHistory(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHistory(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, _) {
        final history = viewModel.ridePreference.reversed.toList();

        return SizedBox(
          height: 200,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: history.length,
            itemBuilder: (ctx, index) => HomeHistoryTile(ridePref: history[index], onPressed: () => _onRidePrefSelected(context, history[index])),
          ),
        );
      },
    );
  }

  Widget _buildBackground() {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Image.asset(blablaHomeImagePath, fit: BoxFit.cover),
    );
  }
}
