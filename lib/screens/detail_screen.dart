import 'package:flutter/material.dart';
import 'package:prueba_pragma/models/cat_information.dart';

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
            Color(0xFFA0EAF8),
            Color(0xFF98F9B5),
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
                  fontSize: 25,
                  color: Color(0xFF333333)),
            ),
          ),
        ),
        body: Column(
          children: [
            Image.network(
                height: 350,
                width: 500,
                _getURLImage(widget.catInformation.imageId) ?? "",
                fit: BoxFit.cover, errorBuilder: (BuildContext context,
                    Object exception, StackTrace? stackTrace) {
              return Image.asset(
                "assets/images/defaultcat.png",
                fit: BoxFit.fill,
              );
            }),
            const SizedBox(height: 25),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.description,
                    color: Color(0xFF2D9CDB)),
                Text(
                  "Description",
                  style: TextStyle(
                      fontWeight:
                      FontWeight.bold,
                      fontSize: 25,
                      color: Color(0xFF666666)),
                )
              ],
            ),
            const SizedBox(height: 25),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 5, color: const Color(0xFFE0E0E0)),
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20, top: 20),
                      child: Text(widget.catInformation.description,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Color(0xFF666666)),
                          textAlign: TextAlign.justify),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String? _getURLImage(String? imageId) {
    if (imageId != null) {
      return "https://cdn2.thecatapi.com/images/$imageId.jpg";
    }
    return null;
  }
}
