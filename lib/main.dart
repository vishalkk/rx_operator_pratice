import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

testInt() async {
  final stream1 = Stream.periodic(
      const Duration(seconds: 1), (count) => "count1 is $count");

  final stream2 = Stream.periodic(
      const Duration(seconds: 3), (count) => "count2 is $count");

  final streamCombine = Rx.combineLatest2(
      stream1, stream2, (one, two) => "one = $one , two = $two  result  ");

  await for (final value in streamCombine) {
    value.log();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    testInt();
    return Scaffold(
      appBar: AppBar(title: const Text("Homepage")),
      body: Column(children: const []),
    );
  }
}
