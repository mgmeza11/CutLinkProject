import 'package:cut_link_project/view/widgets/status_icon_widget.dart';
import 'package:flutter/material.dart';

class DialogWidget extends StatelessWidget {
  DialogWidget(this.iconType, this.message);

  final StatusIconType iconType;
  String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: StatusIconWidget(
          iconType,
          message
        ),
      actions: [
        TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text(
              'OK',
              style: TextStyle(
                  color: Color.fromRGBO(52, 152, 219, 1.0),
                  fontSize: 18,
                  fontWeight: FontWeight.w600
              ),
              textAlign: TextAlign.center,
            )
        )
      ],
    );
  }
}
