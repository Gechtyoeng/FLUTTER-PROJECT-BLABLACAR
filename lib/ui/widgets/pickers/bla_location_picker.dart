import 'package:blabla/data/repositories/locations/location_repository.dart';
import 'package:blabla/ui/widgets/display/bla_divider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/ride/locations.dart';
import '../../theme/theme.dart';

///
/// A  Location Picker is a view to pick a Location:
///
class BlaLocationPicker extends StatefulWidget {
  const BlaLocationPicker({super.key, required this.initLocation});

  final Location? initLocation; // optional initial location

  @override
  State<BlaLocationPicker> createState() => _BlaLocationPickerState();
}

class _BlaLocationPickerState extends State<BlaLocationPicker> {
  String currentSearchText = "";
  List<Location> locations = [];
  bool isLoading = false;

  late LocationRepository locationRepo; // read the repo latter

  void onTap(Location location) {
    Navigator.pop<Location>(context, location);
  }

  void onBackTap() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    locationRepo = Provider.of<LocationRepository>(context, listen: false);

    // Initilize the search bar if any initial location
    if (widget.initLocation != null) {
      setState(() {
        currentSearchText = widget.initLocation!.name;
      });
    }
  }

  void onSearchChanged(String search) {
    setState(() {
      currentSearchText = search;
    });
  }

  //Filter locations
  Future<void> _filterLocations(String search) async {
    setState(() {
      currentSearchText = search;
      isLoading = true;
    });

    if (search.length < 2) {
      locations = [];
    } else {
      locations = await locationRepo.filterLocation(search);
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: BlaSpacings.m, right: BlaSpacings.m, top: BlaSpacings.s),
        child: Column(
          children: [
            LocationSearchBar(initSearch: currentSearchText, onBackTap: onBackTap, onSearchChanged: _filterLocations),

            SizedBox(height: 20),

            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: locations.length,
                      itemBuilder: (context, index) => LocationTile(location: locations[index], onTap: onTap),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class LocationSearchBar extends StatefulWidget {
  const LocationSearchBar({super.key, required this.onBackTap, required this.onSearchChanged, required this.initSearch});

  final String initSearch;
  final VoidCallback onBackTap;
  final ValueChanged<String> onSearchChanged;

  @override
  State<LocationSearchBar> createState() => _LocationSearchBarState();
}

class _LocationSearchBarState extends State<LocationSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void onClearTap() {
    setState(() {
      _searchController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.initSearch;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
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
                  onPressed: onClearTap,
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
