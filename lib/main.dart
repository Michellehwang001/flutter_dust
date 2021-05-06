import 'package:dust/air_provider.dart';
import 'package:dust/bloc/air_bloc.dart';
import 'package:dust/models/AirResult.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

// 최상위 변수로 Bloc 선언
//final airBloc = AirBloc();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => AirProvider(),),
    ],
      child: Consumer<AirProvider>(
        builder: (context, airResult, _),
      )
    );

  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  final airResult = Provider.of<AirProvider>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('미세먼지앱'),
      ),
      body: Center(
        child: StreamBuilder<AirResult>(
            stream: airBloc.airResult,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return buildBody(snapshot.data);
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }

  Widget buildBody(AirResult _result) {
    return Padding(
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
                        Text('풍속 ${_result.data.current.weather.ws}m/s'),
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
              onPressed: () {
                print('fetch()');
                airBloc.fetch();
              },
              child: Icon(Icons.refresh),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.orange),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  //side: BorderSide(color: Colors.red) // border line color
                )),
              ),
            ),
          ],
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
