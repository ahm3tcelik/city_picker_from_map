import 'package:flutter/material.dart';
import './city_painter.dart';
import '../models/city.dart';
import '../parser.dart';
import '../size_controller.dart';

class CityPickerMap extends StatefulWidget {
  final double? width;
  final double? height;
  final String map;
  final Function(City? city) onChanged;
  final Color? strokeColor;
  final Color? selectedColor;
  final Color? dotColor;
  final bool? actAsToggle;

  CityPickerMap(
      {Key? key,
      required this.map,
      required this.onChanged,
      this.width,
      this.height,
      this.strokeColor,
      this.selectedColor,
      this.dotColor,
      this.actAsToggle}) : super(key: key);

  @override
  CityPickerMapState createState() => CityPickerMapState();
}

class CityPickerMapState extends State<CityPickerMap> {
  final List<City> _cityList = [];
  City? selectedCity;

  final _sizeController = SizeController.instance;
  Size? mapSize;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_){
      _loadCityList();
    });
  }

  _loadCityList() async {
    final list = await Parser.instance.svgToCityList(widget.map);
    _cityList.clear();
    setState(() {
      _cityList.addAll(list);
      mapSize = _sizeController.mapSize;
    });
  }

  void clearSelect() {
    setState(() {
      selectedCity = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          for (var city in _cityList) _buildStackItem(city),
        ],
      ),
    );
  }

  Widget _buildStackItem(City city) {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: () => (widget.actAsToggle ?? false)
          ? _toggleButton(city)
          : _useButton(city),
      child: CustomPaint(
        child: Container(
          width: widget.width ?? double.infinity,
          height: widget.height ?? double.infinity,
          constraints: BoxConstraints(
              maxWidth: mapSize?.width ?? 0, maxHeight: mapSize?.height ?? 0),
          alignment: Alignment.center,
        ),
        isComplex: true,
        foregroundPainter: CityPainter(
            city: city,
            selectedCity: selectedCity,
            dotColor: widget.dotColor,
            selectedColor: widget.selectedColor,
            strokeColor: widget.strokeColor),
      ),
    );
  }

  void _toggleButton(City city) {
    setState(() {
      if (selectedCity == city)
        selectedCity = null;
      else {
        selectedCity = city;
      }
      widget.onChanged.call(selectedCity);
    });
  }

  void _useButton(City city) {
    setState(() {
      selectedCity = city;
      widget.onChanged.call(selectedCity);
    });
  }
}
