import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'constants.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AdaptiveFlatButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: onPressed,
            child: const Text('Choose date',
                style: TextStyle(
                  color: accentColor,
                )),
          )
        : TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              foregroundColor: accentColor,
            ),
            child: const Text('Choose date'),
          );
  }
}
