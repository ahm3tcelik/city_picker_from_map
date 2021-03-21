import 'package:city_picker_from_map/city_picker_from_map.dart';
import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

class CityPainter extends CustomPainter {
  final City city;
  final City? selectedCity;
  late final Path path;
  final Color? strokeColor;
  final Color? selectedColor;
  final Color? dotColor;

  CityPainter(
      {required this.city,
      required this.selectedCity,
      this.selectedColor,
      this.strokeColor,
      this.dotColor}) {
    path = parseSvgPath(city.path);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // print('Canvas Sizes: ${size.width} ${size.height}');

    final pen = Paint()
      ..color = strokeColor ?? Colors.white60
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final selectedPed = Paint()
      ..color = selectedColor ?? Colors.blue
      ..strokeWidth = 1.0
      ..style = PaintingStyle.fill;

    final redDot = Paint()
      ..color = dotColor ?? Colors.red
      ..strokeWidth = 3.0
      ..style = PaintingStyle.fill;

    final bounds = path.getBounds();

    // canvas.scale(0.9, 0.9);

    if (city.id == selectedCity?.id) {
      canvas.drawPath(path, selectedPed);
    }
    canvas.drawCircle(bounds.center, 3.0, redDot);
    canvas.drawPath(path, pen);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  @override
  bool hitTest(Offset position) {
    // return path.contains(position.scale(10/9, 10/9));
    return path.contains(position);
  }
}
