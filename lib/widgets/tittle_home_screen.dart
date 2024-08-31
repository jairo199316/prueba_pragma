import 'package:flutter/material.dart';
import 'package:prueba_pragma/utilities/colors.dart';
import 'package:prueba_pragma/utilities/dimens.dart';
import 'package:prueba_pragma/utilities/strings.dart';

class TittleHomeScreen extends StatelessWidget {
  const TittleHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.center,
      child: Text(
        tittleHomeScreen,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: sizeTittleHomeScreen,
            color: tittleColor),
      ),
    );
  }
}
