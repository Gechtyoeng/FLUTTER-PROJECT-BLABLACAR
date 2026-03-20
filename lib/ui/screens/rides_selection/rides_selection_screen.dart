import 'package:blabla/ui/screens/rides_selection/widgets/ride_selection_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blabla/data/repositories/rides/ride_repository.dart';
import 'package:blabla/ui/states/ride_preference_state.dart';
import 'ride_selection_view_model.dart';

class RidesSelectionScreen extends StatelessWidget {
  const RidesSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rideState = context.read<RidePreferenceState>();
    final rideRepo = context.read<RideRepository>();

    return ChangeNotifierProvider<RideSelectionViewModel>(
      create: (_) => RideSelectionViewModel(rideRepo: rideRepo, rideState: rideState),
      child: Consumer<RideSelectionViewModel>(
        builder: (context, viewModel, _) {
          return RideSelectionContent(rideVM: viewModel);
        },
      ),
    );
  }
}
