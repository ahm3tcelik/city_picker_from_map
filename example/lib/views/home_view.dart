import 'package:city_picker_from_map/city_picker_from_map.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  City? selectedCity;
  final GlobalKey<CityPickerMapState> _mapKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected City: ${selectedCity?.title ?? '(?)'}'),
        actions: [
          IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                setState(() {
                  _mapKey.currentState?.clearSelect();
                });
              })
        ],
      ),
      body: Center(
        child: Container(
          child: InteractiveViewer(
            scaleEnabled: true,
            panEnabled: true,
            constrained: true,
            child: CityPickerMap(
              key: _mapKey,
              width: double.infinity,
              height: double.infinity,
              country: TurkeyMap(),
              onChanged: (city) {
                setState(() {
                  selectedCity = city;
                });
              },
              actAsToggle: true,
              dotColor: Colors.red,
              selectedColor: Colors.blue,
              strokeColor: Colors.white24,
            ),
          ),
        ),
      ),
    );
  }
}
