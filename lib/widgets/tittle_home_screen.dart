import 'package:flutter/material.dart';

class TittleHomeScreen extends StatelessWidget {
  const TittleHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.center,
      child: Text(
        'Catbreeds',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Color(0xFF333333)),
      ),
    );
  }
}
