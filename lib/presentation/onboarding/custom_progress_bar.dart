import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final double progress;
  const CustomProgressBar({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 8,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.white,
              ),
            ),
            AnimatedContainer(
              width: (MediaQuery.of(context).size.width - 32) * progress,
              duration: const Duration(milliseconds: 300),
              height: 8,
              curve: Curves.easeIn,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Color(0xFF4A4999),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
