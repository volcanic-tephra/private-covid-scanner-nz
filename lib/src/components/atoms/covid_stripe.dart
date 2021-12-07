import 'package:flutter/material.dart';

class _Settings {
  static const _foregroundColour = Color.fromARGB(255, 255, 204, 0);
  static const _barWidthPercent = 0.10;

  static get foregroundColour {
    return _foregroundColour;
  }

  static get barWidthPercent {
    return _barWidthPercent;
  }
}

class CovidStripe extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final barWidth = size.width * _Settings.barWidthPercent;

    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = _Settings.foregroundColour
      ..isAntiAlias = true;

    final bars = (size.width / (size.width * _Settings.barWidthPercent)) + 2;

    for (var n = 0; n <= bars; n += 2) {
      var stripe = Path()
        ..moveTo(barWidth * (n - 1), size.height)
        ..lineTo(barWidth * n, 0)
        ..lineTo(barWidth * (n + 1), 0)
        ..lineTo(barWidth * n, size.height)
        ..lineTo(barWidth, size.height);
      canvas.drawPath(stripe, paint);
    }

    canvas.save();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
