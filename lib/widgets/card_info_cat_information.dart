import 'package:flutter/material.dart';
import 'package:prueba_pragma/models/cat_information.dart';
import 'package:prueba_pragma/utilities/colors.dart';
import 'package:prueba_pragma/utilities/dimens.dart';
import 'package:prueba_pragma/widgets/modal_info_cat_information.dart';

class CardInfoCatInformation extends StatelessWidget {
  const CardInfoCatInformation({
    super.key,
    required this.icon,
    required this.label,
    this.method,
    this.catInformation,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Function(CatInformation, BuildContext context)? method;
  final CatInformation? catInformation;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(paddingLabelInfoCatHomeSreen),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: sizeBorder, color: borderLabelInfo),
            borderRadius: BorderRadius.circular(borderLabelInfoCatHomeSreen),
            color: color),
        child: Padding(
          padding: const EdgeInsets.only(
            left: paddingLabelInfoCatHomeSreen,
            right: paddingLabelInfoCatHomeSreen,
          ),
          child: GestureDetector(
            onTap: () {
              if (method != null) {
                method!(catInformation!, context);
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ModalInfoCatInformation(icon: icon, label: label);
                  },
                );
              }
            },
            child: Row(
              children: [
                Icon(icon, color: iconsColor),
                Text(
                  _getLabel(label),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: sizeTextLabelInfoCatHomeSreen,
                      color: descriptionColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getLabel(String name) {
    if (name.length <= 10) {
      return name;
    }
    return name.replaceRange(7, name.length, '...');
  }
}
