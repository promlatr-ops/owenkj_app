import 'package:flutter/material.dart';

class SimpleCustomWidget extends StatelessWidget {
  final String label;
  const SimpleCustomWidget({super.key, this.label = 'Demo'});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      ),
      child: Text(label, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
