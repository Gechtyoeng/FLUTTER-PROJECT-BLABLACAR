import 'package:blabla/model/ride/locations.dart';
import 'package:blabla/ui/theme/theme.dart';
import 'package:blabla/ui/widgets/display/bla_divider.dart';
import 'package:flutter/material.dart';
import 'package:blabla/services/location_service.dart';

class BlaLocationPicker extends StatefulWidget {
  final Location? searchLocation;
  const BlaLocationPicker({super.key, this.searchLocation});

  @override
  State<BlaLocationPicker> createState() => _RideLocationPickerState();
}

class _RideLocationPickerState extends State<BlaLocationPicker> {
  String currentSearchText = "";

  void onTap(Location location) {
    Navigator.pop(context, location);
  }

  void onBackTap() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    if (widget.searchLocation != null) {
      currentSearchText = widget.searchLocation!.name;
    }
  }

  void onSearchChanged(String search) {
    setState(() {
      currentSearchText = search;
    });
  }

  //get filter locations
  List<Location> get filteredLocation {
    if (currentSearchText.length <= 2) return [];
    return LocationsService.availableLocations.where((location) => location.name.toLowerCase().contains(currentSearchText.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: BlaSpacings.m, right: BlaSpacings.m, top: BlaSpacings.s),
        child: Column(
          children: [
            //SEARCH BAR
            LocationSearchBar(searchText: currentSearchText, onBackTap: onBackTap, onSearchChanged: onSearchChanged),
            const SizedBox(height: 20),

            //SEARCH RESULT
            Expanded(
              child: ListView.builder(
                itemCount: filteredLocation.length,
                itemBuilder: (context, index) => LocationTile(location: filteredLocation[index], onTap: onTap),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//search bar widget
class LocationSearchBar extends StatefulWidget {
  final String searchText;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onBackTap;
  const LocationSearchBar({super.key, required this.searchText, required this.onBackTap, required this.onSearchChanged});

  @override
  State<LocationSearchBar> createState() => _LocationSearchBarState();
}

class _LocationSearchBarState extends State<LocationSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.searchText;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  //clear the text in search bar
  void onClear() {
    _searchController.clear();
  }

  bool get searchIsNotEmpty => _searchController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: BlaColors.greyLight),
      child: Row(
        children: [
          // BACK ICON
          IconButton(
            onPressed: widget.onBackTap,
            icon: Icon(Icons.arrow_back_ios, color: BlaColors.iconLight, size: 16),
          ),
          // TEXT FILED
          Expanded(
            child: TextField(
              focusNode: _focusNode, // Keep focus
              controller: _searchController,
              onChanged: widget.onSearchChanged,
              style: TextStyle(color: BlaColors.textLight),
              decoration: InputDecoration(
                hintText: "Any city, street...",
                border: InputBorder.none, // No border
                filled: false, // No background fill
              ),
            ),
          ),
          // CLOSE ICON
          searchIsNotEmpty
              ? IconButton(
                  onPressed: onClear,
                  icon: Icon(Icons.close, color: BlaColors.iconLight, size: 16),
                )
              : SizedBox.shrink(), // Hides the icon if text field is empty
        ],
      ),
    );
  }
}

class LocationTile extends StatelessWidget {
  const LocationTile({super.key, required this.location, required this.onTap});

  final Location location;

  final ValueChanged<Location> onTap;

  String get title => location.name;

  String get subTitle => location.country.name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () => onTap(location),
          leading: Icon(Icons.history, color: BlaColors.iconLight),

          title: Text(title, style: BlaTextStyles.body),
          subtitle: Text(subTitle, style: BlaTextStyles.label.copyWith(color: BlaColors.textLight)),

          trailing: Icon(Icons.arrow_forward_ios, color: BlaColors.iconLight, size: 16),
        ),
        BlaDivider(),
      ],
    );
  }
}
