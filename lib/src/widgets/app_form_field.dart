import "package:admin_panel/src/utils/app_colors/colors.dart";
import "package:flutter/material.dart";

class AppFormField extends StatelessWidget {
  const AppFormField({
    super.key,
    this.hintText,
    this.labelText = '',
    this.maxLine = 1,
    this.isSecure,
    this.textEditingController,
    this.textInputType = TextInputType.text,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
  });

  final String? hintText;
  final String? labelText;
  final bool? isSecure;
  final int? maxLine;
  final TextEditingController? textEditingController;
  final TextInputType? textInputType;
  final Widget? suffixIcon;
  final IconData? prefixIcon;
  final Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (String? value) {
        if (validator != null) {
          return validator!(value);
        } else {
          return null;
        }
      },
      controller: textEditingController,
      keyboardType: textInputType,
      obscureText: isSecure ?? false,
      maxLines: maxLine,
      decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: Icon(prefixIcon),
          hintText: hintText,
          label: Text("$labelText"),
          fillColor: AppColors.whiteColor,
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide:
                  const BorderSide(width: 2.0, color: AppColors.successGreen)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide:
                  const BorderSide(width: 2.0, color: AppColors.failureRed)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide:
                  const BorderSide(width: 2.0, color: AppColors.successGreen)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide:
                  const BorderSide(width: 2.0, color: AppColors.successGreen))),
    );
  }
}
