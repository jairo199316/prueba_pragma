import 'package:flutter/material.dart';
import 'package:prueba_pragma/utilities/colors.dart';
import 'package:prueba_pragma/utilities/dimens.dart';

class ModalInfoCatInformation extends StatelessWidget {
  const ModalInfoCatInformation({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          padding: const EdgeInsets.all(0),
          child: Dialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Container(
                  height: 80,
                  width: 50,
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, color: iconsColor),
                      Text(
                        label,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: sizeTextLabelInfoCatHomeSreen,
                            color: descriptionColor),
                      )
                    ],
                  )))),
    );
  }
}
