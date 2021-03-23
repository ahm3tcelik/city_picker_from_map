import 'package:svg_path_parser/svg_path_parser.dart';
import 'package:flutter/services.dart' show rootBundle;
import './size_controller.dart';
import './constant.dart';
import './models/city.dart';

class Parser {
  static Parser? _instance;

  static Parser get instance {
    _instance ??= Parser._init();
    return _instance!;
  }

  final sizeController = SizeController.instance;

  Parser._init();

  Future<List<City>> svgToCityList(String country) async {

    final svgCountry = await rootBundle.loadString(
      '${Constants.ASSETS_PATH}/$country'
    );

    List<City> cityList = [];

    final regExp = RegExp(Constants.MAP_REGEXP,
        multiLine: true, caseSensitive: false, dotAll: false);

    regExp.allMatches(svgCountry).forEach((cityData) {
      final city = City(
          id: cityData.group(1)!,
          title: cityData.group(2)!,
          path: parseSvgPath(cityData.group(3)!));

      sizeController.addBounds(city.path.getBounds());
      cityList.add(city);
    });
    return cityList;
  }
}
