import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
enum StatusIconType{
  ok,
  error
}

class StatusIconWidget extends StatelessWidget{

  StatusIconWidget(this.iconType, this.message);

  final StatusIconType iconType;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(iconType == StatusIconType.ok? ';)' : ':(',
          style: TextStyle(
              color: iconType == StatusIconType.ok? Color.fromRGBO(52, 152, 219, 1.0) : Colors.redAccent,
              fontSize: 70,
              fontWeight: FontWeight.w800
          ),
          textAlign: TextAlign.center
        ),
        if(message!= null) Padding(
          padding: const EdgeInsets.all(10), //apply padding to all four sides
          child: Text(message!),
        )
      ],
    );
  }
}