import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final double value;
  final ValueChanged<double> onChanged;
  final SliderTrackShape trackShape;
  final SliderComponentShape thumbShape;

  const CustomSlider({
    super.key,
    required this.activeTrackColor,
    required this.inactiveTrackColor,
    required this.value,
    required this.onChanged,
    required this.trackShape,
    required this.thumbShape,
  });

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 3,
        trackShape: trackShape,
        thumbShape: thumbShape,
        overlayShape: SliderComponentShape.noOverlay,
        activeTrackColor: activeTrackColor,
        inactiveTrackColor: inactiveTrackColor,
      ),
      child: Slider(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}

class CustomSliderTrackShape extends RectangularSliderTrackShape {
  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
  }) {
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    // Active track
    final activeTrackPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            trackRect.left,
            trackRect.top,
            thumbCenter.dx - trackRect.left,
            trackRect.height,
          ),
          const Radius.circular(4),
        ),
      );

    // Inactive track
    final inactiveTrackPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            thumbCenter.dx,
            trackRect.top,
            trackRect.right - thumbCenter.dx,
            trackRect.height,
          ),
          const Radius.circular(4),
        ),
      );

    context.canvas.drawPath(
      activeTrackPath,
      Paint()..color = sliderTheme.activeTrackColor ?? Colors.white,
    );

    context.canvas.drawPath(
      inactiveTrackPath,
      Paint()..color = sliderTheme.inactiveTrackColor ?? Colors.grey,
    );
  }
}

class CustomSliderThumbShape extends SliderComponentShape {
  final double thumbRadius;
  final double thumbHeight;
  final double thumbWidth;

  const CustomSliderThumbShape(
      {this.thumbRadius = 1.0, this.thumbHeight = 8.0, this.thumbWidth = 3.0});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(thumbRadius * 2, thumbHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
              center: center, width: thumbWidth, height: thumbHeight),
          Radius.circular(thumbRadius),
        ),
        fillPaint);
  }
}
