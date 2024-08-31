import 'package:flutter/material.dart';
import 'package:prueba_pragma/utilities/dimens.dart';
import 'package:prueba_pragma/utilities/get_url_image_util.dart';
import 'package:prueba_pragma/utilities/images_routes_assets.dart';

class ImageCardCatInformation extends StatelessWidget {
  const ImageCardCatInformation({super.key, required this.imageId});

  final String? imageId;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: heightImageCardHomeScreen,
          width: widthImageCardeHomeScreen,
          decoration: BoxDecoration(
            border: Border.all(width: sizeBorder),
            borderRadius: BorderRadius.circular(imageCardBorderCatHomeScreen),
          ),
          child: Image.network(getUrlImage(imageId) ?? "", fit: BoxFit.fill,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
            return Image.asset(
              defaultCat,
              fit: BoxFit.fill,
            );
          }),
        ),
      ],
    );
  }
}
