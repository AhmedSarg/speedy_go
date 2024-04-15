import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speedy_go/presentation/resources/color_manager.dart';

import '../app/sl.dart';
import '../data/data_source/remote_data_source.dart';
import '../domain/models/enums.dart';
import '../presentation/resources/values_manager.dart';

late final WidgetsBinding engine;

void main() async {
  engine = WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
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
  late Future<Stream<List<dynamic>>> str;

  int? _selectedIndex;

  @override
  void initState() {
    super.initState();

    var rem = RemoteDataSourceImpl(sl(), sl(), sl());

    str = rem.findDrivers(
      passengerId: '9a2a6870-1a0b-1f5c-8a97-55979f1354eb',
      tripType: TripType.car,
      pickupLocation: const LatLng(0, 0),
      destinationLocation: const LatLng(1, 1),
      price: 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Stream<List<dynamic>>>(
            future: str,
            builder: (context, ft) {
              if (ft.hasData) {
                return StreamBuilder(
                  stream: ft.data,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        padding: const EdgeInsets.all(AppPadding.p20),
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (_selectedIndex == index) {
                                  _selectedIndex = null;
                                }
                                else {
                                  _selectedIndex = index;
                                }
                              });
                            },
                            child: Container(
                              color: _selectedIndex == index
                                  ? ColorManager.primary
                                  : ColorManager.offwhite,
                              padding: const EdgeInsets.all(AppPadding.p10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    snapshot.data![index]['id'],
                                    style: TextStyle(
                                      color: _selectedIndex == index
                                          ? ColorManager.offwhite
                                          : ColorManager.primary,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data![index]['price'].toString(),
                                    style: TextStyle(
                                      color: _selectedIndex == index
                                          ? ColorManager.offwhite
                                          : ColorManager.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => const Divider(
                          height: AppSize.s30,
                        ),
                        itemCount: snapshot.data!.length,
                      );
                    } else {
                      return const Placeholder();
                    }
                  },
                );
              } else {
                return const Placeholder();
              }
            }),
      ),
    );
  }
}
