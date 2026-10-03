import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final bool compact;
  const AppLogo({super.key, this.compact = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: compact ? 38 : 48,
          height: compact ? 38 : 48,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(
            Icons.local_laundry_service,
            color: Colors.white,
          ),
        ),
        if (!compact) ...[
          const SizedBox(width: 12),
          Text(
            'LaundryLink',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ],
    );
  }
}
