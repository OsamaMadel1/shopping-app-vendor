// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class SocialIcon extends StatelessWidget {
  final Icon icon;
  final Color color;

  const SocialIcon({super.key, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: CircleAvatar(
        backgroundColor: color.withOpacity(0.2),
        child: IconButton(
          icon: icon,
          color: color,
          onPressed: () {},
        ),
      ),
    );
  }
}
