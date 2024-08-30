import 'package:flutter/material.dart';
import 'package:prueba_pragma/models/cat_information.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prueba_pragma/screens/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<CatInformation> _catsInformation = [];
  late List<CatInformation> _catsInformationFilter = [];

  Future<List<CatInformation>> _getCatsInformation() async {
    var headers = {
      'x-api-key':
          'ive_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr',
    };
    final response = await http.get(
        Uri.parse("https://api.thecatapi.com/v1/breeds"),
        headers: headers);
    final List<CatInformation> catsInformation = [];
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for (var catInformation in jsonData) {
        catsInformation.add(CatInformation(
          catInformation["name"],
          catInformation["origin"],
          catInformation["intelligence"].toString(),
          catInformation["reference_image_id"],
          catInformation["description"],
        ));
      }
      return catsInformation;
    } else {
      throw Exception("Fallo la conexion");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final data = await _getCatsInformation();
    setState(() {
      _catsInformation = data;
      _catsInformationFilter = data;
    });
  }

  void filterByName(String query) {
    List<CatInformation> auxCatsInformationList = [];
    auxCatsInformationList.addAll(_catsInformation);
    if (query.isNotEmpty) {
      List<CatInformation> auxCatsInformationData = [];
      for (var element in auxCatsInformationList) {
        if (element.name.toLowerCase().startsWith(query.toLowerCase())) {
          auxCatsInformationData.add(element);
        }
      }
      setState(() {
        _catsInformationFilter = auxCatsInformationData;
      });
    } else {
      setState(() {
        _catsInformationFilter = _catsInformation;
      });
    }
  }

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
        appBar: AppBar(toolbarHeight: 0),
        body: Column(
          children: [
            const SizedBox(height: 25),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Catbreeds',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Color(0xFF333333)),
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                onChanged: (query) {
                  filterByName(query);
                },
                decoration: const InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search_off_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: ListView.builder(
                itemCount: _catsInformationFilter.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 5, color: Colors.transparent),
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 5,
                                        color: const Color(0xFFE0E0E0)),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                            Icons.card_membership_outlined,
                                            color: Color(0xFF2D9CDB)),
                                        Text(
                                          _getName(_catsInformationFilter[index]
                                              .name),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Color(0xFF666666)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 5,
                                          color: const Color(0xFFE0E0E0)),
                                      borderRadius: BorderRadius.circular(50),
                                      color: const Color(0xFF98F9B5)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                              catInformation:
                                                  _catsInformationFilter[index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Row(
                                        children: [
                                          Icon(Icons.remove_red_eye,
                                              color: Color(0xFF2D9CDB)),
                                          Text(
                                            "See more",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Color(0xFF666666)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),
                          Row(
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
                                    _getURLImage(_catsInformationFilter[index]
                                            .imageId) ??
                                        "",
                                    fit: BoxFit.fill, errorBuilder:
                                        (BuildContext context, Object exception,
                                            StackTrace? stackTrace) {
                                  return Image.asset(
                                    "assets/images/defaultcat.png",
                                    fit: BoxFit.fill,
                                  );
                                }),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 5,
                                        color: const Color(0xFFE0E0E0)),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.location_on,
                                            color: Color(0xFF2D9CDB)),
                                        Text(
                                          _getOrigin(
                                              _catsInformationFilter[index]
                                                  .origin),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Color(0xFF666666)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 5,
                                        color: const Color(0xFFE0E0E0)),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.lightbulb_rounded,
                                            color: Color(0xFF2D9CDB)),
                                        Text(
                                          _catsInformationFilter[index]
                                              .intelligence,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Color(0xFF666666)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
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

  String _getName(String name) {
    if (name.length <= 10) {
      return name;
    }
    return name.replaceRange(7, name.length, '...');
  }

  String _getOrigin(String origin) {
    if (origin.length <= 10) {
      return origin;
    }
    return origin.replaceRange(7, origin.length, '...');
  }
}
