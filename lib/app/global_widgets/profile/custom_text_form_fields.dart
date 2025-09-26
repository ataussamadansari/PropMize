import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextFormFields extends StatelessWidget {
  final String label;
  final String hint;
  final bool obscureText;
  final bool enabled;
  final TextEditingController controller;
  final int? maxLine;
  final bool singleLine;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType keyboardType;

  const CustomTextFormFields({
    super.key,
    required this.label,
    required this.hint,
    required this.obscureText,
    required this.enabled,
    required this.controller,
    this.maxLine,
    this.singleLine = true,
    this.focusNode,
    this.nextFocus,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2,
      children: [
        SizedBox(height: 3),
        Text(label, style: context.textTheme.labelLarge?.copyWith(color: Colors.grey, fontWeight: FontWeight.bold)),
        // 👇 Agar enabled hai to TextFormField, warna read-only Text
        enabled
            ? TextFormField(
          controller: controller,
          enabled: enabled,
          obscureText: obscureText,
          minLines: singleLine ? 1 : maxLine,
          maxLines: singleLine ? 1 : maxLine,
          focusNode: focusNode,
          keyboardType: keyboardType,
          textInputAction: singleLine
              ? (nextFocus != null ? TextInputAction.next : TextInputAction.done)
              : TextInputAction.newline,
          onFieldSubmitted: (_) {
            if (nextFocus != null) {
              FocusScope.of(context).requestFocus(nextFocus);
            } else {
              FocusScope.of(context).unfocus();
            }
          },
          decoration: InputDecoration(
            hintText: hint,
          ),
        )
            : Text(
          controller.text.isEmpty ? hint : controller.text,
          maxLines: maxLine,
          overflow: TextOverflow.ellipsis, // jyada hua to ... dikhayega
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: controller.text.isEmpty
                ? context.textTheme.bodySmall?.color
                : enabled ? context.textTheme.titleLarge?.color : context.textTheme.bodySmall?.color,
          ),
        ),

        /*TextFormField(
          controller: controller,
          enabled: enabled,
          obscureText: obscureText,
          minLines: singleLine ? 1 : maxLine,
          maxLines: singleLine ? 1 : maxLine,
          focusNode: focusNode,
          textInputAction: singleLine
              ? (nextFocus != null ? TextInputAction.next : TextInputAction.done)
              : TextInputAction.newline, // 👈 handle bio/multiline
          onFieldSubmitted: (_) {
            if (nextFocus != null) {
              FocusScope.of(context).requestFocus(nextFocus); // 👈 jump to next
            } else {
              FocusScope.of(context).unfocus(); // 👈 close keyboard
            }
          },
          decoration: InputDecoration(
            hintText: hint,
          ),
        )*/
      ],
    );
  }
}
