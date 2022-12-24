import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  const CustomTextForm({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFFFECED),
            blurRadius: 0,
            spreadRadius: 4,
            offset: Offset(0, 0),
          )
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.name,
        autocorrect: false,
        autovalidateMode: AutovalidateMode.always,
        textCapitalization: TextCapitalization.words,
        enableInteractiveSelection: false,
        enableSuggestions: false,
        maxLines: maxLines,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: const Color(0xFF4A6680),
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w400,
          color: Color(0xFF4A6680),
        ),
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: Colors.grey[500],
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 14,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color(0xFF4A6680),
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color(0xFF4A6680),
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
