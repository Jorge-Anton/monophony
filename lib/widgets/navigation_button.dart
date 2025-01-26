import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final String text;
  final bool active;
  final IconData icon;
  final int quarterTurns;
  final VoidCallback? onPressed;

  const NavigationButton({
    super.key,
    required this.text,
    required this.active,
    required this.icon,
    this.quarterTurns = 0,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
        ),
        child: Column(
          children: [
            AnimatedSlide(
              duration: Durations.short3,
              curve: Cubic(0.32, 0.72, 0, 1),
              offset: Offset(0, active ? 0 : -1),
              child: AnimatedOpacity(
                duration: Durations.short3,
                curve: Cubic(0.32, 0.72, 0, 1),
                opacity: active ? 1 : 0,
                child: RotatedBox(
                  quarterTurns: quarterTurns,
                  child: Icon(
                    icon,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            AnimatedDefaultTextStyle(
              duration: Durations.short3,
              curve: const Cubic(0.32, 0.72, 0, 1),
              style: TextStyle(
                color: active ? Colors.black : Colors.grey[700],
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
