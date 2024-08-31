class GetUrlImageUtil {

  static String? getUrlImage(String? imageId) {
    if (imageId != null) {
      return "https://cdn2.thecatapi.com/images/$imageId.jpg";
    }
    return null;
  }
}
