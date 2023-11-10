import 'package:flutter/material.dart';

class RectangularCheckboxButton extends StatelessWidget {
  final String checkedText;
  final String uncheckedText;
  final bool isChecked;
  final Function() onToggle;

  RectangularCheckboxButton({
    required this.checkedText,
    required this.uncheckedText,
    required this.isChecked,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
            isChecked ? Colors.red : Color.fromARGB(255, 4, 14, 59)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      onPressed: onToggle,
      child: Row(
        children: [
          Icon(
            isChecked ? Icons.check : Icons.check_box_outline_blank,
            color: Colors.white,
          ),
          Text(isChecked ? checkedText : uncheckedText),
        ],
      ),
    );
  }
}
