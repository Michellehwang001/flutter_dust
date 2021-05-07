import 'package:dust/bloc/air_provider.dart';
import 'package:dust/models/AirResult.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Provider 생성
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AirProvider() ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 시작하면서 fetchData() 를 실행한다. fetchData는 void
    Provider.of<AirProvider>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    //Provider를 제공받는다.
    AirProvider airProvider = Provider.of<AirProvider>(context);
    AirResult result = airProvider.result;

    return Scaffold(
      appBar: AppBar(
        title: Text('미세먼지앱'),
      ),
      body: Center(
        child: airProvider.isLoading
            ? CircularProgressIndicator()
            : buildBody(result),
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
                // 다시 fetch() 불러야 함.
                print('fetch()');
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
