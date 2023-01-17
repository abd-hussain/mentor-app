import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mentor_app/shared_widget/custom_text_style.dart';

class CustomAttachTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final Function(String text)? onChange;

  const CustomAttachTextField({required this.controller, required this.hintText, this.onChange, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: TextField(
        controller: controller,
        style: CustomTextStyle().regular(color: const Color(0xff191C1F), size: 14),
        cursorColor: const Color(0xff100C31),
        decoration: InputDecoration(
          fillColor: Colors.white,
          labelText: hintText,
          suffixIcon: const Icon(
            Ionicons.document_attach_outline,
            size: 20,
            color: Color(0xff444444),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffE8E8E8)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffE8E8E8)),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffE8E8E8)),
          ),
          filled: true,
          labelStyle: CustomTextStyle().regular(color: const Color(0xff384048), size: 14),
        ),
        onChanged: (text) {
          if (onChange != null) {
            onChange!(text);
          }
        },
      ),
    );
  }
}
