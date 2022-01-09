//https://api.coingecko.com/api/v3/coins/smooth-love-potion

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

const String url = "https://api.coingecko.com/api/v3/coins/";
const Map<String, String> endpoints = {
  "slp": "smooth-love-potion",
  //more endpoints
};

class MarketAPIHelper {
  static Future<double> fetchSlpMarketValue() async {
    final _response = await http.get(
      Uri.parse(url + endpoints['slp'].toString()),
      headers: {
        'accept': 'application/json',
      }
    );
    if (_response.statusCode == 200) {
      Map<String, dynamic> _json = jsonDecode(_response.body);
      log("SLP Market Value: "+_json['market_data']['current_price']['php'].toString());
      return Future(()=>_json['market_data']['current_price']['php']);
    } else {
      throw Exception('Failed to fetch SLP stats');
    }
  }
}
