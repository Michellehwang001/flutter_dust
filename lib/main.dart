import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('미세먼지앱'),
      ),
      body: Padding(
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
                            '80',
                            style: TextStyle(fontSize: 40),
                          ),
                          Text(
                            '보통',
                            style: TextStyle(fontSize: 40),
                          ),
                        ],
                      ),
                      color: Colors.yellow,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Text('이미지'),
                              SizedBox(
                                width: 16,
                              ),
                              Text(
                                '11º',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          Text('습도 100%'),
                          Text('풍속 5.7m/s'),
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
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
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
}
