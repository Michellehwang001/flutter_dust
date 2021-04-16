// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dust/main.dart';
import 'package:http/http.dart' as http;

void main() {
  test('http 통신 테스트', () async {
    var response = await http.get('http://api.airvisual.com/v2/nearest_city?key=4e4a2b11-55a1-4f0c-839a-2dd00e9de7d7');

    expect(response.statusCode, 200);
  });
}
