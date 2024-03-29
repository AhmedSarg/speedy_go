import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice_plus/places.dart';

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
  const WidgetTest({
    super.key
  });

  @override
  State<WidgetTest> createState() => _WidgetTestState();
}

class _WidgetTestState extends State<WidgetTest> {

  final _places = GoogleMapsPlaces(
      apiKey: 'AIzaSyAk5wVPHzUelaMzxTZJ-ybERq42ULBusf0',
  );

  late final List<PlacesSearchResult> _placesList;

  Future<List<PlacesSearchResult>> searchPlaces(String query, LatLng location) async {
    final result = await _places.searchNearbyWithRadius(
      Location(lat: location.latitude, lng: location.longitude),
      10000,
      type: "restaurant",
    );
    if (result.status == "OK") {
      return result.results;
    } else {
      throw Exception(result.errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('fef'),
          onPressed: () async {
            _placesList = await searchPlaces('query', const LatLng(30.4762175,31.1800514));
            Navigator.push(context, MaterialPageRoute(builder: (context) => Places(placesList: _placesList)));
          },
        ),
      )
    );
  }
}

class Places extends StatelessWidget {
  const Places({super.key, required this.placesList});
  
  final List<PlacesSearchResult> placesList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: placesList.length,
        itemBuilder: (context, index) {
          final place = placesList[index];
          return ListTile(
            title: Text(place.name),
            subtitle: Text(place.vicinity!),
          );
        },
      ),
    );
  }
}


// Container(
// width: w,
// height: h,
// color: Colors.green,
// child: Stack(
// children: [
// Positioned(
// height: 500,
// width: 50,
// right: w,
// bottom: 0,
// child: OverflowBox(
// maxHeight: 90000,
// maxWidth: 50,
// child: RotationTransition(
// turns: const AlwaysStoppedAnimation(45 / 360),
// child: Container(
// width: AppSize.infinity,
// height: AppSize.infinity,
// color: Colors.red,
// child: const Icon(Icons.arrow_back),
// ),
// ),
// ),
// ),
// ],
// ),
// ),

// RotationTransition(
// turns: const AlwaysStoppedAnimation(45 / 360),
// child: Row(
// children: [
// GestureDetector(
// onTap: () {
// setState(() {
// DataIntent.setSelection(Selection.driver);
// });
// },
// child: AnimatedContainer(
// duration: const Duration(milliseconds: 300),
// width: selection == Selection.none
// ? context.width() / 2
//     : (selection == Selection.driver
// ? context.width() * .9
//     : context.width() * .1),
// alignment: Alignment.center,
// color: Colors.red,
// child: Transform.rotate(
// angle: -.5,
// child: const Text("driver"),
// ),
// ),
// ),
// GestureDetector(
// onTap: () {
// setState(() {
// DataIntent.setSelection(Selection.passenger);
// });
// },
// child: AnimatedContainer(
// duration: const Duration(milliseconds: 300),
// width: selection == Selection.none
// ? context.width()
//     : (selection == Selection.passenger
// ? context.width() * .9
//     : context.width() * .1),
// alignment: Alignment.center,
// color: Colors.blue,
// child: Transform.rotate(
// angle: -.5,
// child: const Text("passenger"),
// ),
// ),
// )
// ],
// ),
// ),
