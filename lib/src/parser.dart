import 'package:city_picker_from_map/src/size_controller.dart';
import 'package:svg_path_parser/svg_path_parser.dart';
import './constant.dart';
import './interface/ISvgCountry.dart';
import './models/city.dart';

class Parser {
  static Parser? _instance;

  static Parser get instance {
    _instance ??= Parser._init();
    return _instance!;
  }

  final sizeController = SizeController.instance;

  Parser._init();

  List<City> svgToCityList(ISvgCountry country) {
    List<City> cityList = [];

    final regExp = RegExp(Constants.MAP_REGEXP,
        multiLine: true, caseSensitive: false, dotAll: false);

    regExp.allMatches(country.svgData).forEach((cityData) {
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
