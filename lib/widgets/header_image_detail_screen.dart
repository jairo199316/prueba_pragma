import 'package:flutter/material.dart';
import 'package:prueba_pragma/utilities/dimens.dart';
import 'package:prueba_pragma/utilities/get_url_image_util.dart';
import 'package:prueba_pragma/utilities/images_routes_assets.dart';

class HeaderImageDetailScreen extends StatelessWidget {
  const HeaderImageDetailScreen({super.key, this.imageId});

  final String? imageId;

  @override
  Widget build(BuildContext context) {
    return Image.network(
        height: heightHeaderImageDetailScreen,
        width: widthHeaderImageDetailScreen,
        getUrlImage(imageId) ?? "",
        fit: BoxFit.cover, errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
      return Image.asset(
        defaultCat,
        fit: BoxFit.fill,
      );
    });
  }
}
