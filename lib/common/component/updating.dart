import 'package:flutter/material.dart';
import 'package:my_gstore/common/theme/theme_text.dart';

class Updating extends StatelessWidget {
  final String srcImg;
  final String label;
  final String textFunction;
  final Function onTap;

  const Updating(
      {Key? key,
      required this.srcImg,
      required this.label,
      required this.textFunction,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              srcImg,
              width: MediaQuery.of(context).size.width - 100.0,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              label,
              style: AppTextTheme.normalGrey,
            ),
            GestureDetector(
              onTap: () {
                onTap();
              },
              child: Text(
                textFunction,
                style: AppTextTheme.normalBlue,
              ),
            )
          ],
        ),
      ),
    );
  }
}
