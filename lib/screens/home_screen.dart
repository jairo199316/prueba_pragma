import 'package:flutter/material.dart';
import 'package:prueba_pragma/models/cat_information.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:prueba_pragma/screens/detail_screen.dart';
import 'package:prueba_pragma/widgets/card_info_cat_information.dart';
import 'package:prueba_pragma/widgets/tittle_home_screen.dart';
import 'package:prueba_pragma/widgets/image_card_cat_information.dart';

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
            const TittleHomeScreen(),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                onChanged: (query) {
                  filterByName(query);
                },
                decoration: const InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search_outlined),
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
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 5, color: Colors.transparent),
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CardInfoCatInformation(
                                icon: Icons.card_membership_outlined,
                                label: _catsInformationFilter[index].name,
                                color: Colors.white,
                              ),
                              CardInfoCatInformation(
                                  icon: Icons.remove_red_eye,
                                  label: "See more",
                                  method: goToDetailScreen,
                                  catInformation: _catsInformationFilter[index],
                                  color: const Color(0xFF98F9B5))
                            ],
                          ),
                          ImageCardCatInformation(
                              imageId: _catsInformationFilter[index].imageId),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CardInfoCatInformation(
                                  icon: Icons.location_on,
                                  label: _catsInformationFilter[index].origin,
                                  color: Colors.white),
                              CardInfoCatInformation(
                                  icon: Icons.lightbulb_rounded,
                                  label:
                                      _catsInformationFilter[index].intelligence,
                                  color: Colors.white),
                            ],
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

  void goToDetailScreen(CatInformation catInformation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          catInformation: catInformation,
        ),
      ),
    );
  }
}
