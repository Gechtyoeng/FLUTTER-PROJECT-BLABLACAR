import 'package:blabla/ui/theme/theme.dart';
import 'package:blabla/ui/widgets/display/bla_divider.dart';
import 'package:flutter/material.dart';

class RidePrefInput extends StatelessWidget {
  final IconData leftIcon;
  final IconData? rightIcon;

  final String title;

  final VoidCallback onclick;
  final VoidCallback? onRightIconClick;

  // If true the text is displayed ligher
  final bool isPlaceHolder;

  const RidePrefInput({super.key, required this.title, required this.leftIcon, required this.onclick, this.onRightIconClick, this.rightIcon, this.isPlaceHolder = false});

  @override
  Widget build(BuildContext context) {
    Color textColor = isPlaceHolder ? BlaColors.textLight : BlaColors.textNormal;

    return Column(
      children: [
        ListTile(
          leading: Icon(leftIcon, color: BlaColors.iconLight),
          title: Text(title, style: BlaTextStyles.button.copyWith(fontSize: 14, color: textColor)),
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
