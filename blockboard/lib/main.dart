import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clipboard_listener/clipboard_listener.dart';
// import 'package:flutter_background/flutter_background.dart';
import 'package:home_widget/home_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HomeWidget.registerBackgroundCallback(backgroundCallback);
  runApp(const MyApp());
}

// Called when Doing Background Work initiated from Widget
Future<void> backgroundCallback(Uri? uri) async {
  if (uri?.host == 'updatecounter') {
    int counter = 0;
    await HomeWidget.getWidgetData<int>('_counter', defaultValue: 0)
        .then((value) {
      counter = value!;
      counter++;
    });
    await HomeWidget.saveWidgetData<int>('_counter', counter);
    await HomeWidget.updateWidget(
        //this must the class name used in .Kt
        name: 'HomeScreenWidgetProvider',
        iOSName: 'HomeScreenWidgetProvider');
  }
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
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    HomeWidget.widgetClicked.listen((Uri? uri) => loadData());
    loadData(); // This will load data from widget every time app is opened
  }

  void loadData() async {
    await HomeWidget.getWidgetData<int>('_counter', defaultValue: 0)
        .then((value) {
      _counter = value!;
    });
    setState(() {});
  }

  Future<void> updateAppWidget() async {
    await HomeWidget.saveWidgetData<int>('_counter', _counter);
    await HomeWidget.updateWidget(
        name: 'HomeScreenWidgetProvider', iOSName: 'HomeScreenWidgetProvider');
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    updateAppWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// class _MyHomePageState extends State<MyHomePage> {
//   final TextEditingController _controller = TextEditingController();

  // final androidConfig = const FlutterBackgroundAndroidConfig(
  //   notificationTitle: "flutter_background example app",
  //   notificationText: "Background notification for keeping the example app running in the background",
  //   notificationImportance: AndroidNotificationImportance.Default,
  //   notificationIcon: AndroidResource(name: 'background_icon', defType: 'drawable'), // Default is ic_launcher from folder mipmap
  // );
  // bool success = await FlutterBackground.initialize(androidConfig: androidConfig);

//   @override
//   void initState() {
//     super.initState();



    // Clipboard.onChanged.listen((event) {
    //   Clipboard.getData(Clipboard.kTextPlain).then((value) {
    //     _controller.text = "copied text: ${value!.text}";
    //   });
    // });
    // ClipboardListener.addListener(() async {
    //   _controller.text =
    //       "copied text: ${(await Clipboard.getData(Clipboard.kTextPlain))!.text}";


//     ClipboardListener.addListener(() async {
//       _controller.text =
//           "copied text: ${(await Clipboard.getData(Clipboard.kTextPlain))!.text}";
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
            // children: [
            //   TextField(
            //     decoration: InputDecoration(
            //       labelText: "This is label, copy thiss"
            //     ),
            //   ),
            //   SizedBox(height: 20),
            //   TextField(
            //     controller: _controller,
            //     decoration: const InputDecoration(
            //       border: OutlineInputBorder(),
            //       labelText: 'Copied text',
            //     ),
//           children: [
//             Text(
//               "Copy text from anywhere and it will be fetched here! 🤩",
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 40),
//             TextField(
//               controller: _controller,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Copied text',
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//                 onPressed: () {
//                   Clipboard.setData(
//                       ClipboardData(text: "This will be fetched from server"));
//                 },
//                 child: Text("Copy Text")),
//           ],
//         ),
//       ),
//     );
//   }
// }
