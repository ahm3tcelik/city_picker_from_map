import 'package:flutter/material.dart';

import './city_painter.dart';
import '../interface/ISvgCountry.dart';
import '../models/city.dart';
import '../parser.dart';

class CityPickerMap extends StatefulWidget {
  final ISvgCountry country;
  final Function(City? city) onChanged;
  final Color? strokeColor;
  final Color? selectedColor;
  final Color? dotColor;

  CityPickerMap(
      {required this.country,
      required this.onChanged,
      this.strokeColor,
      this.selectedColor,
      this.dotColor});

  @override
  _CityPickerMapState createState() => _CityPickerMapState();
}

class _CityPickerMapState extends State<CityPickerMap> {
  late final List<City> cityList;
  City? selectedCity;

  @override
  void initState() {
    cityList = Parser.instance.svgToCityList(widget.country);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (var city in cityList) _buildStackItem(city),
      ],
    );
  }

  Widget _buildStackItem(City city) {
    // print("Screem Sizes: ${MediaQuery.of(context).size.width} ${MediaQuery.of(context).size.height}");

    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: () {
        setState(() {
          selectedCity = city;
          widget.onChanged.call(selectedCity);
        });
      },
      child: CustomPaint(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        foregroundPainter: CityPainter(
            city: city,
            selectedCity: selectedCity,
            dotColor: widget.dotColor,
            selectedColor: widget.selectedColor,
            strokeColor: widget.strokeColor),
      ),
    );
  }
}
