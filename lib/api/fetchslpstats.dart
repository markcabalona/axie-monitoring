import 'dart:convert';
import 'dart:developer';

import 'package:axie_monitoring/models/slp.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

const String url = "https://axie-infinity.p.rapidapi.com/";
const Map<String, String> endpoints = {
  "slpStats": "get-update/",
  //more endpoints
};

class AxieApiHelper {
  static Future<SlpStats> fetchSlpStats(String roninId) async {
    final _response = await http.get(
      Uri.parse(url + endpoints['slpStats'].toString() + roninId),
      headers: {
        'x-rapidapi-host': 'axie-infinity.p.rapidapi.com',
        'x-rapidapi-key': env['API_KEY']!,
      },
    );

    if (_response.statusCode == 200) {
      log(_response.body);
      Map<String, dynamic> _json = jsonDecode(_response.body);
      return Future(() => SlpStats.fromJson(_json['slp']));
    } else {
      throw Exception('Server Error.');
    }
  }
}
