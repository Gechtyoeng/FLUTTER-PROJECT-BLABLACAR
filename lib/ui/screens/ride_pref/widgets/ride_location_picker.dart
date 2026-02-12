import 'package:blabla/model/ride/locations.dart';
import 'package:blabla/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:blabla/services/location_service.dart';

class RideLocationPicker extends StatefulWidget {
  final Location? searchLocation;
  const RideLocationPicker({super.key, this.searchLocation});

  @override
  State<RideLocationPicker> createState() => _RideLocationPickerState();
}

class _RideLocationPickerState extends State<RideLocationPicker> {
  final _searchController = TextEditingController();
  //function to clear search text
  void clearSearch() {
    _searchController.clear();
  }

  //get the locations
  List<Location> get filteredLocation {
    return LocationsService.availableLocations.where((location) => location.name.toUpperCase().contains(_searchController.text.toUpperCase())).toList();
  }

  @override
  void initState() {
    super.initState();
    if (widget.searchLocation != null) {
      _searchController.text = widget.searchLocation!.name.toString();
    }

    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new, color: BlaColors.iconLight, size: 20),
        ),
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(border: InputBorder.none, hintText: "Please choose a location"),
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: Icon(Icons.clear, color: BlaColors.iconLight, size: 20),
              onPressed: clearSearch,
            ),
        ],
      ),
    );
  }
}
