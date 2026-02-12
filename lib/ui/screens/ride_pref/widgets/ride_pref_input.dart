import 'package:blabla/ui/theme/theme.dart';
import 'package:blabla/ui/widgets/display/bla_divider.dart';
import 'package:flutter/material.dart';

class RidePrefInput extends StatelessWidget {
  final IconData leftIcon;
  final IconData? rightIcon;

  final String title;

  final VoidCallback onclick;
  final VoidCallback? onRightIconClick;

  const RidePrefInput({super.key, required this.title, required this.leftIcon, required this.onclick, this.onRightIconClick, this.rightIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(leftIcon, color: BlaColors.iconLight),
          title: Text(title, style: BlaTextStyles.label.copyWith(color: BlaColors.neutral)),
          onTap: onclick,
          trailing: rightIcon != null
              ? IconButton(
                  onPressed: onRightIconClick,
                  icon: Icon(rightIcon, color: BlaColors.iconLight),
                )
              : null,
        ),
        BlaDivider(),
      ],
    );
  }
}
