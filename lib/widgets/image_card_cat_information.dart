import 'package:flutter/material.dart';
import 'package:prueba_pragma/utilities/get_url_image_util.dart';

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
          height: 200,
          width: 220,
          decoration: BoxDecoration(
            border: Border.all(width: 5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.network(
              GetUrlImageUtil.getUrlImage(imageId) ?? "",
              fit: BoxFit.fill, errorBuilder: (BuildContext context,
                  Object exception, StackTrace? stackTrace) {
            return Image.asset(
              "assets/images/defaultcat.png",
              fit: BoxFit.fill,
            );
          }),
        ),
      ],
    );
  }
}
