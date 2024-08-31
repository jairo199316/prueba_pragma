import 'package:prueba_pragma/models/cat_information.dart';
import 'package:prueba_pragma/utilities/strings.dart';
import 'package:prueba_pragma/utilities/url_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CatInformationRepository {
  Future<List<CatInformation>> getCatsInformation() async {
    var headers = {
      'x-api-key': apiKey,
    };
    final response = await http.get(Uri.parse(urlApi), headers: headers);
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      List jsonData = jsonDecode(body);
      return jsonData
          .map((catInformation) => CatInformation.fromJson(catInformation))
          .toList();
    } else {
      throw Exception(failConection);
    }
  }
}
