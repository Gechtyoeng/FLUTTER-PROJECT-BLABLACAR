import 'package:blabla/ui/screens/home/home_view_model.dart';
import 'package:blabla/ui/screens/home/widgets/home_content.dart';
import 'package:blabla/ui/states/ride_preference_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(rideState: Provider.of<RidePreferenceState>(context, listen: false)),
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, _) {
          return HomeContent(homeVM: viewModel);
        },
      ),
    );
  }
}
