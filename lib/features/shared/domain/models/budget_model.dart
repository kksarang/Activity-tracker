import 'package:freezed_annotation/freezed_annotation.dart';

part 'budget_model.freezed.dart';
part 'budget_model.g.dart';

@freezed
sealed class BudgetModel with _$BudgetModel {
  const factory BudgetModel({
    required String id,
    required String uid,
    required String month, // YYYY-MM
    required double limit,
    @Default(0.0) double currentWait,
    @Default(true) bool alertsEnabled,
  }) = _BudgetModel;

  factory BudgetModel.fromJson(Map<String, dynamic> json) =>
      _$BudgetModelFromJson(json);
}
