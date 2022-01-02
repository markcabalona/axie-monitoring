import 'dart:convert';
import 'dart:developer';

import 'package:axie_monitoring/models/slp.dart';
import 'package:http/http.dart' as http;

const String url = "https://axie-infinity.p.rapidapi.com/";
const Map<String, String> endpoints = {
  "slpStats": "get-update/",
  //more endpoints
};

class ApiHelper {
  static Future<SlpStats> fetchSlpStats(String roninId) async {
    final _response = await http.get(
      Uri.parse(url + endpoints['slpStats'].toString() + roninId),
      headers: {
        'x-rapidapi-host': 'axie-infinity.p.rapidapi.com',
        'x-rapidapi-key': '62e9221155mshe5a56cf16a518a4p12886cjsnaf3e3bdddf82'
      },
    );

    if (_response.statusCode == 200) {
      
      Map<String, dynamic> _json = jsonDecode(_response.body);
      log(_json['slp'].toString());
      return Future(() => SlpStats.fromJson(_json['slp']));
    } else {
      throw Exception('Failed to fetch SLP stats');
    }
  }
}
