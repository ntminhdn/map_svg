import 'package:flutter/material.dart';
import 'package:mapsvg/mapsvg.dart';
import 'package:mapsvg/utils.dart';
import 'package:mapsvg/paint_data.dart';

void main() {
  runApp(const MaterialApp(home: MapWidget()));
}

class MapWidget extends StatelessWidget {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (_, constraints) => CustomPaint(
          painter: MapPainter(loadMap()),
          size: constraints.biggest,
        ),
      ),
    );
  }
}

class MapPainter extends CustomPainter {
  final List<PaintData> paints;

  MapPainter(this.paints);

  @override
  void paint(Canvas canvas, Size size) {
    const ratio = kWidth / kHeight;
    var width = size.width;
    var height = width / ratio;
    if (height > size.height) {
      height = size.height;
      width = height * ratio;
    }

    canvas.save();

    canvas.translate((size.width - width) / 2, (size.height - height) / 2);
    canvas.scale(width / kWidth, height / kHeight);

    for (final element in paints) {
      canvas.drawPath(element.path, element.paint);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
