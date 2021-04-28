import 'package:dust/models/AirResult.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rxdart/rxdart.dart';

class AirBloc {
  final _airSubject = BehaviorSubject<AirResult>();

  AirBloc(){
    fetch();
  }

  Future<AirResult> fetchData() async {
    var uri = Uri.parse(
        'https://api.airvisual.com/v2/nearest_city?key=4e4a2b11-55a1-4f0c-839a-2dd00e9de7d7');
    var response = await http.get(uri);
    // var response = await http.get(
    //     'https://api.airvisual.com/v2/nearest_city?key=4e4a2b11-55a1-4f0c-839a-2dd00e9de7d7');
    AirResult result = AirResult.fromJson(json.decode(response.body));

    return result;
  }

  void fetch() async {
    var airResult = await fetchData();
    _airSubject.add(airResult);
  }

  // Stream 형태로 외부로 빼준다
  Stream<AirResult> get airResult => _airSubject.stream;

}