import 'package:flutter/material.dart';

showError(BuildContext context, String text, [Duration? duration]) {
  SnackBar snackBar = CustomSnackBar(
    context: context,
    icon: const Icon(
      Icons.error,
      color: Colors.white,
    ),
    backgroundColor: Colors.redAccent,
    text: text,
    duration: duration,
  );
  showSnackBar(context, snackBar);
}

showSnackBar(BuildContext context, SnackBar snackBar) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

class CustomSnackBar extends SnackBar {
  CustomSnackBar({
    Key? key,
    required BuildContext context,
    required String text,
    required Color backgroundColor,
    Duration? duration,
    Icon? icon,
  }) : super(
          key: key,
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
          duration: duration ?? const Duration(milliseconds: 2000),
          content: Row(
            children: <Widget>[
              icon ?? Container(),
              if (icon != null) const SizedBox(width: 20) else Container(),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
}
