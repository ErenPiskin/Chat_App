import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color textColor;


  const CustomButton({super.key,required this.text,required this.onPressed,required this.buttonColor,required this.textColor});

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
          onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
        ),
          child: Text(text,
          style: TextStyle(color: textColor),),

    );
  }
}
