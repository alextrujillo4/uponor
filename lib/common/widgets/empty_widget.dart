import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final String message;

  const EmptyWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/nope.jpg',
            // Adjust the path to your empty image asset
            width: 240, // Adjust the width of the image as needed
            height: 240, // Adjust the height of the image as needed
          ),
          const SizedBox(height: 20),
          Text(
            message,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
