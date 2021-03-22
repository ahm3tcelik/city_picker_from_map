import 'package:city_picker_from_map/city_picker_from_map.dart';
import 'package:city_picker_from_map/src/size_controller.dart';
import 'package:flutter/material.dart';

class CityPainter extends CustomPainter {
  final City city;
  final City? selectedCity;
  final Color? strokeColor;
  final Color? selectedColor;
  final Color? dotColor;

  final sizeController = SizeController.instance;

  double _scale = 1.0;

  CityPainter(
      {required this.city,
      required this.selectedCity,
      this.selectedColor,
      this.strokeColor,
      this.dotColor});

  @override
  void paint(Canvas canvas, Size size) {

    final pen = Paint()
      ..color = strokeColor ?? Colors.white60
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final selectedPen = Paint()
      ..color = selectedColor ?? Colors.blue
      ..strokeWidth = 1.0
      ..style = PaintingStyle.fill;

    final redDot = Paint()
      ..color = dotColor ?? Colors.red
      ..strokeWidth = 3.0
      ..style = PaintingStyle.fill;

    final bounds = city.path.getBounds();

    _scale = sizeController.calculateScale(size);
    canvas.scale(_scale);

    if (city.id == selectedCity?.id) {
      canvas.drawPath(city.path, selectedPen);
    }
    canvas.drawCircle(bounds.center, 3.0, redDot);
    canvas.drawPath(city.path, pen);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  @override
  bool hitTest(Offset position) {
    double inverseScale = sizeController.inverseOfScale(_scale);
    return city.path.contains(position.scale(inverseScale, inverseScale));
  }
}
