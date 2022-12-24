import 'package:flutter/material.dart';
import 'package:triathlon_tracker/core/s.dart';
import 'package:triathlon_tracker/presentation/onboarding/custom_text_form.dart';

class NameScreen extends StatelessWidget {
  final TextEditingController nameController;
  const NameScreen({
    Key? key,
    required this.nameController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 36),
          Text(
            S.of(context).greetings,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: Color(0xFF9EA1B2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 36),
            child: Text(
              S.of(context).your_name_is,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Color(0xFF40445C),
              ),
            ),
          ),
          CustomTextForm(
            controller: nameController,
            hintText: S.of(context).enter_your_name,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
