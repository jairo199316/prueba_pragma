import 'package:flutter/material.dart';
import 'package:prueba_pragma/models/cat_information.dart';
import 'package:prueba_pragma/utilities/colors.dart';
import 'package:prueba_pragma/utilities/dimens.dart';
import 'package:prueba_pragma/utilities/strings.dart';
import 'package:prueba_pragma/widgets/description_detail_screen.dart';
import 'package:prueba_pragma/widgets/header_image_detail_screen.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.catInformation});

  final CatInformation catInformation;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          tileMode: TileMode.clamp,
          colors: <Color>[
            firstColorApp,
            secondColorApp,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Align(
            alignment: Alignment.center,
            child: Text(
              widget.catInformation.name,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: sizeTittleDetailScreen,
                  color: tittleColor),
            ),
          ),
        ),
        body: Column(
          children: [
            HeaderImageDetailScreen(imageId: widget.catInformation.imageId),
            const SizedBox(height: sizeSpacing),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.description, color: iconsColor),
                Text(
                  desciptionTittleDetailScreen,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: sizeTittleDescriptionDetailScreen,
                      color: descriptionColor),
                )
              ],
            ),
            const SizedBox(height: sizeSpacing),
            DescriptionDetailScreen(
                description: widget.catInformation.description),
          ],
        ),
      ),
    );
  }
}
