import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final int? maxLine;
  final Key? formKey;
  final String? hintText;
  final TextStyle? style;
  final Function(String)? onChange;
  final VoidCallback? onDone;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final double? contentPaddingHorizontal;
  final double? contentPaddingVertical;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? readOnly;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;
  final TextCapitalization? textCapitalization;
  final FormFieldValidator<String>? onValidate;
  final List<TextInputFormatter>? inputFormattter;

  CustomTextField(
      {this.controller,
      this.onValidate,
      this.focusNode,
      this.style,
      this.textInputType,
      this.suffixIcon,
      this.prefixIcon,
      this.formKey,
      this.maxLine,
      this.inputFormattter,
      this.readOnly = false,
      this.textInputAction,
      this.hintText = '',
      this.onChange,
      this.onDone,
      this.contentPadding,
      this.contentPaddingHorizontal,
      this.contentPaddingVertical,
      this.textCapitalization});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: Colors.white),
      child: TextFormField(
        onChanged: onChange,
        readOnly: readOnly ?? false,
        controller: controller,
        validator: onValidate,
        focusNode: focusNode,
        style: style,
        keyboardType: textInputType,
        textInputAction: textInputAction ?? TextInputAction.newline,
        onEditingComplete: onDone,
        inputFormatters: inputFormattter,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          fillColor: Colors.white,
          hintStyle: AppTextTheme.normalGrey,
          errorStyle: AppTextTheme.normalRobotoBlack.copyWith(
              color: AppColors.red, fontSize: 12, fontWeight: FontWeight.w300),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor, width: 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(
                  vertical: contentPaddingVertical ?? 17.0,
                  horizontal: contentPaddingHorizontal ?? 16.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.grey4, width: 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 0.5),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.red),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
        ),
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        maxLines: maxLine,
      ),
    );
  }
}
