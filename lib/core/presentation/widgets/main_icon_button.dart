import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainIconButton extends StatelessWidget {
  const MainIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.2), // ظل خفيف حسب الثيم
            spreadRadius: 2,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(10),
      child: FloatingActionButton(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: const CircleBorder(),
        onPressed: () {
          context.push('/addProductScreen');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
