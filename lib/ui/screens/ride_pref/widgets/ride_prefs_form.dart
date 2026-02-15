import 'package:blabla/ui/widgets/inputs/bla_location_picker.dart';
import 'package:blabla/ui/screens/ride_pref/widgets/ride_pref_input.dart';
import 'package:blabla/ui/widgets/actions/bla_button.dart';
import 'package:blabla/utils/animations_util.dart';
import 'package:blabla/utils/date_time_utils.dart';
import 'package:flutter/material.dart';

import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    //Fetch the ride prefef data if it is not null
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      requestedSeats = widget.initRidePref!.requestedSeats;
      departureDate = widget.initRidePref!.departureDate;
    } else {
      // initailize the departure date = current date and requested seat to 1
      departureDate = DateTime.now();
      requestedSeats = 1;
      departure == null;
      arrival == null;
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  void onSearch() async {}

  void onDepartureClick() async {
    // 1- Select a location
    Location? departureLocation = await Navigator.of(context).push<Location>(AnimationUtils.createBottomToTopRoute(BlaLocationPicker(searchLocation: departure)));
    // 2- Update the from if needed
    if (departureLocation != null) {
      setState(() {
        departure = departureLocation;
      });
    }
  }

  void onArrivalClick() async {
    // 1- Select a location
    Location? arrivalLocation = await Navigator.of(context).push<Location>(AnimationUtils.createBottomToTopRoute(BlaLocationPicker(searchLocation: arrival)));
    // 2- Update the from if needed
    if (arrivalLocation != null) {
      setState(() {
        arrival = arrivalLocation;
      });
    }
  }

  //function to handle switches location
  void onLocationSwtiches() {
    if (departure == null || arrival == null) return;

    setState(() {
      final temp = departure;
      departure = arrival;
      arrival = temp;
    });
  }

  //handle date picker
  void onDateSelect() {}

  //handle seat picker
  void onSeatSelect() {}

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  String get date => DateTimeUtils.formatDateTime(departureDate); //get the date format
  String get departureText => departure?.name ?? "Living from";
  String get arrivalText => arrival?.name ?? "Going to";

  IconData get locationIcon => departure == null || arrival == null ? Icons.location_on : Icons.circle_outlined;
  bool get isEnableSwitchIcon => departure != null || arrival != null;

  bool get showDeparturePLaceHolder => departure == null;
  bool get showArrivalPLaceHolder => arrival == null;
  // ----------------------------------
  // Build the widgets
  // ----------------------------------

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1 - Input the ride departure
          RidePrefInput(
            isPlaceHolder: showDeparturePLaceHolder,
            title: departureText,
            leftIcon: locationIcon,
            onclick: onDepartureClick,
            rightIcon: isEnableSwitchIcon ? Icons.swap_vert : null,
            onRightIconClick: onLocationSwtiches,
          ),
          // 2 - Input the ride arrival
          RidePrefInput(isPlaceHolder: showArrivalPLaceHolder, title: arrivalText, leftIcon: locationIcon, onclick: onArrivalClick),
          // 3 - Input the ride date
          RidePrefInput(title: date, leftIcon: Icons.date_range, onclick: onDateSelect),
          // 4 - Input the requested number of seats
          RidePrefInput(title: requestedSeats.toString(), leftIcon: Icons.person, onclick: onSeatSelect),
          // start the search
          BlaButton(title: "Search", onClick: onSearch),
        ],
      ),
    );
  }
}
