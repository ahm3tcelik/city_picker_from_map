import 'dart:ui';

import 'package:city_picker_from_map/src/models/map_area.dart';

class SizeController {
  static SizeController? _instance;

  static SizeController get instance {
    _instance ??= SizeController._init();
    return _instance!;
  }

  SizeController._init();

  MapArea _mapArea = MapArea();
  Size mapSize = Size.zero;

  void addBounds(Rect bound) {
    if (_mapArea.anyEmpty) {
      _mapArea
        ..minX = bound.left
        ..maxX = bound.right
        ..minY = bound.top
        ..maxY = bound.bottom;
    } else {
      if (bound.left < _mapArea.minX!) _mapArea.minX = bound.left;
      if (bound.right > _mapArea.maxX!) _mapArea.maxX = bound.right;
      if (bound.top < _mapArea.minY!) _mapArea.minY = bound.top;
      if (bound.bottom > _mapArea.maxY!) _mapArea.maxY = bound.bottom;
    }
    calculateArea();
  }

  void calculateArea() {
    if (_mapArea.anyEmpty) mapSize = Size.zero;

    double width = _mapArea.maxX! - _mapArea.minX!;
    double height = _mapArea.maxY! - _mapArea.minY!;

    mapSize = Size(width, height);
  }
}
