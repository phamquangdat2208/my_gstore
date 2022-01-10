import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Function onPressed;
  final String buttonTitle;
  final Color backGrButton;

  const ButtonWidget(
      {Key? key,
      required this.onPressed,
      required this.buttonTitle,
      required this.backGrButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 48.0,
        decoration: BoxDecoration(
          color: backGrButton,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                buttonTitle,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
