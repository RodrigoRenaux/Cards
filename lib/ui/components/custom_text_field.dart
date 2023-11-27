import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:target_cards/themes/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      this.fieldHeight = 40,
      this.fieldWidth,
      this.tittle,
      this.controller,
      this.focusNode,
      this.validator,
      this.inputAction,
      this.icon,
      this.border = true,
      this.label,
      this.onDone,
      this.onTap})
      : super(key: key);

  final double fieldHeight;
  final double? fieldWidth;
  final String? tittle;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final Widget? icon;
  final TextInputAction? inputAction;
  final bool border;
  final String? label;
  final Function(String value)? onDone;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ResponsiveBuilder(builder: (context, sizingInformation) {
        return SizedBox(
            height: validator != null ? fieldHeight + 30 : fieldHeight,
            width: fieldWidth ?? double.infinity,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (tittle != null)
                Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(tittle!,
                        style:
                            TextStyle(color: AppColors.white, fontSize: 14))),
              Expanded(
                  child: TextFormField(
                      controller: controller,
                      focusNode: focusNode,
                      validator: validator,
                      textInputAction: inputAction ?? TextInputAction.done,
                      onTap: () => onTap != null ? onTap!() : null,
                      onFieldSubmitted: (String value) =>
                          inputAction == TextInputAction.done && onDone != null
                              ? onDone!(value)
                              : null,
                      decoration: InputDecoration(
                          prefixIcon: icon,
                          filled: true,
                          fillColor: AppColors.white,
                          label: label != null
                              ? const Center(
                                  child: Text("Digite seu texto",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)))
                              : null,
                          border: OutlineInputBorder(
                              borderSide: border
                                  ? BorderSide(color: AppColors.black)
                                  : BorderSide.none,
                              borderRadius: BorderRadius.circular(5.0)))))
            ]));
      }),
    );
  }
}
