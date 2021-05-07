import 'package:dust/models/AirResult.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// 젤 먼저 object 만들어준다.
// ChangeNotifier 상속하고 getter 만들어 준다.
// 변화 감지해야 하는 변수에 notifyListeners(); 를 붙인다.
class AirProvider with ChangeNotifier{
  AirResult _result;
  bool _isLoading = true;

  AirResult get result => _result;

  bool get isLoading => _isLoading;

  Future<AirResult> _fetchData() async {
    var uri = Uri.parse(
        'https://api.airvisual.com/v2/nearest_city?key=4e4a2b11-55a1-4f0c-839a-2dd00e9de7d7');
    var response = await http.get(uri);
    AirResult result = AirResult.fromJson(json.decode(response.body));

    return result;
  }

  void fetchData() {
    _isLoading = true;
    _fetchData().then((result) {
      _result = result;
      _isLoading = false;
      notifyListeners();
    });
  }
}