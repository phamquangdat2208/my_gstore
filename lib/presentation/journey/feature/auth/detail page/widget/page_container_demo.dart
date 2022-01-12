import 'package:flutter/material.dart';


class PageContainerDemo extends StatelessWidget {
  final Widget child;
  final int index;
  final int indexSelected;

  const PageContainerDemo(
      {Key? key,
        required this.child,
        required this.index,
        required this.indexSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
        },
        child: Visibility(
          visible: index == indexSelected,
          replacement: const SizedBox(),
          maintainState: true,
          child: child,
        ),
      );
  }
}
