import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final bool isActive;
  final bool hideIcon;
  const CustomButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.hideIcon = false,
    this.isActive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ? onPressed : null,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: isActive
              ? const Color(0xFF4A4999)
              : const Color(0xFF4A4999).withOpacity(0.8),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 14,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            if (!hideIcon) ...[
              const SizedBox(width: 12),
              const Icon(
                CupertinoIcons.arrow_right,
                color: Colors.white,
                size: 18,
              )
            ]
          ],
        ),
      ),
    );
  }
}
