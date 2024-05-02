import 'package:flutter/material.dart';

class VerticalNavButton extends StatelessWidget {
  final String buttonTitle;
  final Widget buttonIcon;
  final void Function() onTap;
  const VerticalNavButton(
      {super.key,
      required this.buttonTitle,
      required this.buttonIcon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300], // Background color for the ListTile
        border: Border(
            bottom: BorderSide(
          color: Colors.grey[400]!, // Color of the bottom border
          width: 1.0, // Thickness of the bottom border
        )), // Border color
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      child: ListTile(
        title: Text(
          buttonTitle,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
        ),
        leading: buttonIcon,
        onTap: onTap,
      ),
    );
  }
}
