import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon icon;
  final String label;
  final Color color;

  const IconButtonWidget({
    super.key,
    required this.onPressed,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      onPressed: onPressed,
      color: color,
      child: SizedBox(
        height: 62,
        width: double.maxFinite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 5),
            icon,
          ],
        ),
      ),
    );
  }
}
