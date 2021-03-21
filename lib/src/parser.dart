import './constant.dart';
import './interface/ISvgCountry.dart';
import './models/city.dart';

class Parser {
  static Parser? _instance;
  static Parser get instance {
    _instance ??= Parser._init();
    return _instance!;
  }
  Parser._init();

  List<City> svgToCityList(ISvgCountry country) {
    List<City> cityList = [];

    final regExp = RegExp(Constants.MAP_REGEXP, multiLine: true,
        caseSensitive: false, dotAll: false);

    regExp.allMatches(country.svgData).forEach((cityData) {
      cityList.add(City(
          id: cityData.group(1)!,
          title: cityData.group(2)!,
          path: cityData.group(3)!));
    });
    return cityList;
  }
}
