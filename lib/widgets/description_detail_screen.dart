import 'package:flutter/material.dart';
import 'package:prueba_pragma/utilities/colors.dart';
import 'package:prueba_pragma/utilities/dimens.dart';

class DescriptionDetailScreen extends StatelessWidget {
  const DescriptionDetailScreen({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: paddingCardCatDetailScreen,
              right: paddingCardCatDetailScreen,
              bottom: paddingCardCatDetailScreen),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: sizeBorder, color: backgroundCards),
                borderRadius: BorderRadius.circular(borderCardCatDetailScreen),
                color: backgroundCards),
            child: Padding(
              padding: const EdgeInsets.all(paddingDescriptionTextDetailSreen),
              child: Text(description,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: sizeDescriptionTextDetailScreen,
                      color: descriptionColor),
                  textAlign: TextAlign.justify),
            ),
          ),
        ),
      ),
    );
  }
}
