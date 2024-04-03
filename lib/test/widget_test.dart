import 'package:flutter/material.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // print(1);
  // String imageUrl = 'hello';
  // try {
  //   imageUrl = await FirebaseStorage.instance
  //       .ref()
  //       .child('293301358_100176086107504_382459513746061380_n.jpg')
  //       .getDownloadURL();
  //   print(imageUrl);
  // } catch (e) {
  //   print(4);
  //   print(e);
  // }
  // print(2);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WidgetTest(),
    );
  }
}

class WidgetTest extends StatefulWidget {
  const WidgetTest({super.key});

  @override
  State<WidgetTest> createState() => _WidgetTestState();
}

class _WidgetTestState extends State<WidgetTest> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
