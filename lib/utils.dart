import 'dart:math';
import 'dart:ui';

import 'package:mapsvg/mapsvg.dart';
import 'package:mapsvg/paint_data.dart';

List<PaintData> loadMap() {
  final List<PaintData> paints = [];
  kPaths.forEach((key, value) {
    paints.add(PaintData(_getCountryByCode(value), Paint()..color = _generateRandomColor()));
  });

  return paints;
}

Path _getCountryByCode(String pathData) {
  final path = Path();

  // ['m', '479.68275,331.6274', ..., 'z']
  final parts = pathData.split(' ');
  final i = parts.iterator;

  List<Offset> points = <Offset>[];

  while (i.moveNext()) {
    final part = i.current;
    switch (part) {
      case 'M':
      case 'm':
        if (i.moveNext()) {
          final offset = ((points.isNotEmpty && part == 'm') ? points.last : const Offset(0, 0)) +
              _parseOffset(i.current);
          points = [offset]; // điểm đầu tiên
        }
        break;
      case 'z':
        // có thể có nhiều 'z' vì nước có nhiều đảo như Indo
        path.addPolygon(points, true);
        break;
      default:
        // vì 'm' là relative path nên các điểm tiếp theo = điểm trước + offset
        final offset = points.last + _parseOffset(part);
        points.add(offset);
    }
  }
  return path;
}

// input: 479.68275,331.6274
// output: Offset
Offset _parseOffset(String str) {
  final l = str.split(',');
  return Offset(double.parse(l[0]), double.parse(l[1]));
}

Color _generateRandomColor() {
  final Random random = Random();
  return Color.fromRGBO(random.nextInt(255), random.nextInt(255), random.nextInt(255), 1);
}
