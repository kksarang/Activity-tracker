import 'package:flutter/material.dart';
import '../../domain/models/activity_model.dart';
import '../../../../core/theme/app_theme.dart';

extension ActivityTypeX on ActivityType {
  IconData get icon {
    switch (this) {
      case ActivityType.income:
        return Icons.arrow_downward_rounded;
      case ActivityType.expense:
        return Icons.receipt_long_rounded;
      case ActivityType.split:
        return Icons.call_split_rounded;
      case ActivityType.settlement:
        return Icons.handshake_rounded;
      case ActivityType.transfer:
        return Icons.compare_arrows_rounded;
      case ActivityType.request:
        return Icons.move_to_inbox_rounded;
    }
  }

  String get label {
    switch (this) {
      case ActivityType.income:
        return 'Income';
      case ActivityType.expense:
        return 'Expense';
      case ActivityType.split:
        return 'Split';
      case ActivityType.settlement:
        return 'Settlement';
      case ActivityType.transfer:
        return 'Transfer';
      case ActivityType.request:
        return 'Request';
    }
  }
}

extension ActivityDirectionX on ActivityDirection {
  String get sign {
    return this == ActivityDirection.credit ? '+' : '-';
  }

  Color color(bool isDark) {
    if (this == ActivityDirection.credit) {
      return AppColors.mint;
    }
    return isDark ? Colors.white : Colors.black87;
  }
}
