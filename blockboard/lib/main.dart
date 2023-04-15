import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clipboard_listener/clipboard_listener.dart';
import 'package:flutter_background/flutter_background.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'BlockBoard'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final androidConfig = const FlutterBackgroundAndroidConfig(
  //   notificationTitle: "flutter_background example app",
  //   notificationText: "Background notification for keeping the example app running in the background",
  //   notificationImportance: AndroidNotificationImportance.Default,
  //   notificationIcon: AndroidResource(name: 'background_icon', defType: 'drawable'), // Default is ic_launcher from folder mipmap
  // );
  // bool success = await FlutterBackground.initialize(androidConfig: androidConfig);


  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Clipboard.onChanged.listen((event) {
    //   Clipboard.getData(Clipboard.kTextPlain).then((value) {
    //     _controller.text = "copied text: ${value!.text}";
    //   });
    // });
    ClipboardListener.addListener(() async {
      _controller.text =
          "copied text: ${(await Clipboard.getData(Clipboard.kTextPlain))!.text}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "This is label, copy thiss"
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Copied text',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Clipboard.setData(
                      ClipboardData(text: "This will be fetched from server"));
                },
                child: Text("Copy Text")),
          ],
        ),
      ),
    );
  }
}
