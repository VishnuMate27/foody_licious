import 'package:flutter/material.dart';
import 'package:foody_licious/core/constant/colors.dart';

class CustomCheckBox extends StatefulWidget {
  bool? isChecked;

  CustomCheckBox({super.key, this.isChecked});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.selected
      };
      if (states.any(interactiveStates.contains)) {
        return kRedColor;
      }
      return kFullWhite;
    }

    return Checkbox(
      checkColor: kFullWhite,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: widget.isChecked,
      onChanged: (bool? value) {
        setState(() {
          widget.isChecked = value!;
        });
      },
    );
  }
}
