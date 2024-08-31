class CatInformation {
  String name;
  String origin;
  String intelligence;
  String? imageId;
  String description;

  CatInformation(
      {required this.name,
      required this.origin,
      required this.intelligence,
      this.imageId,
      required this.description});

  factory CatInformation.fromJson(Map<String, dynamic> json) {
    return CatInformation(
        name: json['name'],
        origin: json['origin'],
        intelligence: json['intelligence'].toString(),
        imageId: json['reference_image_id'],
        description: json['description']);
  }
}
