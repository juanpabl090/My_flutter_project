import 'package:flutter/material.dart';

class BtnCustom extends StatelessWidget {
  const BtnCustom({
      Key? key, 
      required this.printText, 
      required this.onPressed, 
    }): super(key: key);
    
  final String printText;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
      ),
      child: Text(printText),
    );
  }
}
