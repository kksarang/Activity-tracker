import 'package:flutter/material.dart';
import 'glass_container.dart';

class GlassButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final IconData? icon;

  const GlassButton({
    super.key,
    required this.onTap,
    required this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: GlassContainer(
        opacity: 0.2, // Slightly more opaque for button
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        borderRadius: BorderRadius.circular(20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
