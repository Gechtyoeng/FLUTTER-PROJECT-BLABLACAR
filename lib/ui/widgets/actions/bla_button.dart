import 'package:flutter/material.dart';
import '../../theme/theme.dart';

//enum class for button type
enum ButtonType { primary, secondary }

class BlaButton extends StatelessWidget {
  final String title;
  final VoidCallback onClick;
  final ButtonType type;
  final IconData? icon; //icon data can be null
  const BlaButton({super.key, required this.title, required this.onClick, this.type = ButtonType.primary, this.icon});

  bool get isPrimary => type == ButtonType.primary; //return true if button type is primary

  @override
  Widget build(BuildContext context) {
    //compute rendering
    Color backgroundColor = isPrimary ? BlaColors.primary : BlaColors.white;
    Color textColor = isPrimary ? BlaColors.white : BlaColors.primary;
    Color iconColor = isPrimary ? BlaColors.white : BlaColors.primary;

    BorderSide border = isPrimary ? BorderSide.none : BorderSide(color: BlaColors.greyLight, width: 2);

    //create the button if any
    List<Widget> children = [];
    if (icon != null) {
      children.add(Icon(icon, color: iconColor));
      children.add(SizedBox(width: BlaSpacings.s));
    }

    //create the button text
    children.add(Text(title, style: TextStyle(color: textColor)));

    //reder the button
    return SizedBox(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(BlaSpacings.radius)),
          side: border,
        ),
        onPressed: onClick,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: children),
      ),
    );
  }
}
