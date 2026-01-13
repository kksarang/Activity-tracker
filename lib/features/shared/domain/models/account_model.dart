import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_model.freezed.dart';
part 'account_model.g.dart';

@freezed
sealed class AccountModel with _$AccountModel {
  const factory AccountModel({
    required String userId,
    required double currentBalance, // Cash Balance
    @Default(0.0) double openingBalance,
    @Default(0.0) double totalIncome,
    @Default(0.0) double totalExpense,
    @Default(0.0) double totalReceivable,
    @Default(0.0) double totalPayable,
    required DateTime lastUpdated,
  }) = _AccountModel;

  const AccountModel._();

  // Derived Net Worth
  double get netWorth => currentBalance + totalReceivable - totalPayable;

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);
}
