import 'package:flutter/material.dart';
import 'package:prueba_pragma/models/cat_information.dart';

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
  final Function(CatInformation)? method;
  final CatInformation? catInformation;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 5, color: const Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(50),
          color: color
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: GestureDetector(
            onTap: () {
              method!(catInformation!);
            },
            child: Row(
              children: [
                Icon(icon, color: const Color(0xFF2D9CDB)),
                Text(
                  _getLabel(label),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Color(0xFF666666)),
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
