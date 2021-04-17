import 'package:dust/models/AirResult.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  AirResult _result;

  Future<AirResult> fetchData() async {
    var response = await http.get(
        'https://api.airvisual.com/v2/nearest_city?key=4e4a2b11-55a1-4f0c-839a-2dd00e9de7d7');
    AirResult result = AirResult.fromJson(json.decode(response.body));

    return result;
  }

  @override
  void initState() {
    super.initState();

    fetchData().then((airResult) {
      setState(() {
        _result = airResult;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('미세먼지앱'),
      ),
      body: _result == null
          ? CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '현재 위치 미세먼지',
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Card(
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('얼굴사진'),
                                Text(
                                  '${_result.data.current.pollution.aqius}',
                                  style: TextStyle(fontSize: 40),
                                ),
                                Text(
                                  getCondition(_result),
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            color: getColor(_result),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Image.network(
                                      'https://airvisual.com/images/${_result.data.current.weather.ic}.png',
                                      width: 32,
                                      height: 32,
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      '${_result.data.current.weather.tp}º',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                Text('습도 ${_result.data.current.weather.hu}%'),
                                Text(
                                    '풍속 ${_result.data.current.weather.ws}m/s'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Icon(Icons.refresh),
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.orange),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          //side: BorderSide(color: Colors.red) // border line color
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Color getColor(AirResult result) {
    if (result.data.current.pollution.aqius <= 50) {
      return Colors.green;
    } else if (result.data.current.pollution.aqius <= 100) {
      return Colors.yellow;
    } else if (result.data.current.pollution.aqius <= 150) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  String getCondition(AirResult result) {
    if (result.data.current.pollution.aqius <= 50) {
      return '좋음';
    } else if (result.data.current.pollution.aqius <= 100) {
      return '보통';
    } else if (result.data.current.pollution.aqius <= 150) {
      return '나쁨';
    } else {
      return '최악';
    }
  }
}
