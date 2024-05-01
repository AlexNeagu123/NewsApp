import 'package:flutter/material.dart';

class NavBarButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;
  final bool isUnderlined;

  const NavBarButton({
    required this.text,
    required this.icon,
    required this.onPressed,
    required this.color,
    this.isUnderlined = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: isUnderlined
            ? Border(
                bottom: BorderSide(color: Colors.grey[300]!, width: 3.0),
              )
            : const Border(),
      ),
      child: TextButton.icon(
        icon: Icon(icon),
        label: Text(text, style: const TextStyle(color: Colors.black)),
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
