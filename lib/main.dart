import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final BehaviorSubject<DateTime> subject;
  late final Stream<String> streamOfString;
  @override
  void initState() {
    super.initState();
    subject = BehaviorSubject<DateTime>();
    streamOfString = subject.switchMap((dateTime) => Stream.periodic(
          const Duration(seconds: 1),
          (count) => "Stream count = $count, date time  =$dateTime",
        ));
  }

  @override
  void dispose() {
    subject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rx SwitchMap"),
      ),
      body: Column(
        children: [
          StreamBuilder<String>(
              stream: streamOfString,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final str = snapshot.requireData;
                  return Text(str);
                } else {
                  return const Text("waiting for button to pressed");
                }
              }),
          ElevatedButton(
              onPressed: () {
                subject.add(DateTime.now());
              },
              child: const Text("Start the stream"))
        ],
      ),
    );
  }
}
