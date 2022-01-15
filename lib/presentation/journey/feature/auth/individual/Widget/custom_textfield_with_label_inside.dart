import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';

class CustomTextFieldWithLabelInside extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;
  final Function? onTap;
  final Function(String text)? onChanged;
  final bool? haveIconRight;
  final bool? readOnly;
  final bool? forMoney;
  final IconData? iconData;
  final Color? contentColor;
  final List<TextInputFormatter>? inputFormattter;
  final TextCapitalization? textCapitalization;
  final int? maxLength;
  final bool? enableinteractiveSelection;

  const CustomTextFieldWithLabelInside(
      {Key? key,
        this.controller,
        this.hintText,
        this.textInputAction = TextInputAction.done,
        this.textInputType,
        this.focusNode,
        this.validator,
        this.readOnly = false,
        this.onTap,
        this.haveIconRight = false,
        this.iconData,
        this.forMoney = false,
        this.contentColor,
        this.maxLength = 1,
        this.inputFormattter,
        this.enableinteractiveSelection,
        this.onChanged,
        this.textCapitalization})
      : super(key: key);

  @override
  _CustomTextFieldWithLabelInsideState createState() =>
      _CustomTextFieldWithLabelInsideState();
}

class _CustomTextFieldWithLabelInsideState
    extends State<CustomTextFieldWithLabelInside> {
  bool _onlyShowLabel = false;
  FocusNode? _focusNode;

  String _hintText = '';

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    _hintText = widget.hintText ?? '';
    if (widget.controller?.text.isNotEmpty ?? false) {
      _onlyShowLabel = true;
    }
    widget.controller!.addListener(() {
      if (widget.controller?.text.isNotEmpty ?? false) {
        _onlyShowLabel = true;
      }
      setState(() {});
    });
    _focusNode?.addListener(() {
      if ((_focusNode?.hasFocus ?? false) ||
          widget.controller!.text.isNotEmpty) {
        _onlyShowLabel = true;
        _hintText = '';
      } else {
        _onlyShowLabel = false;
        _hintText = widget.hintText ?? '';
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 56.0,
          decoration: BoxDecoration(
              border: Border.all(
                color: (_focusNode?.hasFocus ?? false)
                    ? AppColors.primaryColor
                    : AppColors.grey4,
                width: 1,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              color: AppColors.white),
          child: Row(
            children: [
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: _hintText,
                              hintStyle: AppTextTheme.normalGrey,
                              errorStyle: AppTextTheme.normalRobotoBlack.copyWith(
                                  color: AppColors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300),
                              contentPadding:
                              EdgeInsets.only(top: _onlyShowLabel ? 22 : 4)),
                          textCapitalization:
                          widget.textCapitalization ?? TextCapitalization.none,
                          controller: widget.controller,
                          enableInteractiveSelection:
                          widget.enableinteractiveSelection ?? true,
                          readOnly: widget.readOnly ?? false,
                          textInputAction:
                          widget.textInputAction ?? TextInputAction.done,
                          focusNode: _focusNode,
                          inputFormatters: widget.inputFormattter,
                          keyboardType: widget.textInputType,
                          maxLines: widget.maxLength,
                          cursorColor: AppColors.primaryColor,
                          style: AppTextTheme.normalGrey9.copyWith(
                              color: widget.contentColor ?? AppColors.grey9),
                          validator: widget.validator,
                          onChanged: widget.onChanged,
                        )),
                  ],
                ),
              ),
              (widget.forMoney ?? false)
                  ? const Text('VND ')
                  : const SizedBox(),
              (widget.haveIconRight ?? false)
                  ? Icon(
                widget.iconData ?? Icons.chevron_right,
                color: AppColors.grey6,
              )
                  : const SizedBox(),
            ],
          ),
        ),
        Positioned(
            top: 8,
            left: 16.0,
            child: Visibility(
                visible: _onlyShowLabel,
                child: Text(widget.hintText ?? '',
                    style: AppTextTheme.style12pxGrey6))),
        Visibility(
          visible: widget.onTap != null,
          child: InkWell(
            onTap: () {
              widget.onTap!();
            },
            child: Container(
              width: double.infinity,
              height: 56.0,
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    super.dispose();
  }
}
