import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/common/theme/theme_color.dart';

class CustomCheckBox extends StatefulWidget {
  final Function(bool status)? onChange;
  final Color? backgroundColor;
  final bool? value;
  final bool? selfChangeState;
  final EdgeInsets? padding;

  CustomCheckBox(
      {Key? key,
        this.value = false,
        this.onChange,
        this.backgroundColor = AppColors.primaryColor,
        this.selfChangeState = false,
        this.padding})
      : super(key: key);

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    bool value = (widget.selfChangeState??false) ? _checked : (widget.value??false);
    return InkWell(
      onTap: () {
        if (widget.selfChangeState??false) {
          setState(() {
            _checked = !_checked;
          });
        }
        widget.onChange!(!value);
      },
      child: Padding(
        padding: widget.padding ?? EdgeInsets.all(0),
        child: Container(
          width: 18.0,
          height: 18.0,
          decoration: BoxDecoration(
              color: value ? widget.backgroundColor : Colors.white,
              border:
              value ? null : Border.all(width: 1.0, color: AppColors.grey6),
              borderRadius: BorderRadius.all(Radius.circular(4.0))),
          child: Center(
            child: SvgPicture.asset(
              IconConst.iconCheck,
              width: 12,
              height: 12,
            ),
          ),
        ),
      ),
    );
  }
}
