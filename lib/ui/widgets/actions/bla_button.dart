import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class BlaButton extends StatelessWidget {
  final String title;
  final VoidCallback onClick;
  final bool isPrimary;
  final IconData? icon; //icon data can be null
  const BlaButton({super.key, required this.title, required this.onClick, this.isPrimary = true, this.icon});

  bool get isWithIcon => icon != null;
  @override
  Widget build(BuildContext context) {
    return isPrimary
        ? ElevatedButton.icon(
            onPressed: onClick,
            icon: Icon(isWithIcon ? icon : null),
            style: ElevatedButton.styleFrom(backgroundColor: BlaColors.primary, foregroundColor: BlaColors.white),
            label: Text(title, style: BlaTextStyles.button),
          )
        : OutlinedButton.icon(
            onPressed: onClick,
            icon: Icon(isWithIcon ? icon : null),
            style: OutlinedButton.styleFrom(
              backgroundColor: BlaColors.white,
              foregroundColor: BlaColors.primary,
              side: BorderSide(color: BlaColors.greyLight),
            ),
            label: Text(title, style: BlaTextStyles.button),
          );
  }
}
