import 'package:flutter/material.dart';

class SortingButtons extends StatelessWidget {
  const SortingButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Transform.translate(
          offset: const Offset(8, 0),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.trending_up_rounded,
              color: Theme.of(context).colorScheme.onSurface.withAlpha(180),
            ),
          ),
        ),
        Transform.translate(
          offset: const Offset(4, 0),
          child: IconButton(
            onPressed: () {},
            icon: Text(
              'Aa',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface.withAlpha(180),
              ),
            ),
            // iconSize: 22,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.access_time_filled_rounded),
          iconSize: 22,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 2.0),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_upward_rounded),
          ),
        ),
      ],
    );
  }
}
