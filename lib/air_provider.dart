import 'dart:convert';
import 'package:dust/models/AirResult.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// with 키워드 추상키워드를 선택적으로 사용?
class AirProvider with ChangeNotifier {
  AirResult _airResult = AirResult();

  AirResult get airResult => _airResult;

  Future<AirResult> fetchData() async {
    var uri = Uri.parse(
        'https://api.airvisual.com/v2/nearest_city?key=4e4a2b11-55a1-4f0c-839a-2dd00e9de7d7');
    var response = await http.get(uri);
    AirResult result = AirResult.fromJson(json.decode(response.body));

    return result;
  }

  void fetch() async {
    _airResult = await fetchData();
    notifyListeners();
  }
}
