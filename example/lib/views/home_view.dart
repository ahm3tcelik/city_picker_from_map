import 'package:city_picker_from_map/city_picker_from_map.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  City? selectedCity;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Selected City: ${selectedCity?.title ?? '(?)'}'),
      ),
      body: Center(
        child: Container(
          child: InteractiveViewer(
            scaleEnabled: true,
            panEnabled: true,
            constrained: true,
            child: CityPickerMap(
              country: TurkeyMap(),
              onChanged: (city) {
                print('SELECTED: ${city?.title}');
                setState(() {
                  selectedCity = city;
                });
              },
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
