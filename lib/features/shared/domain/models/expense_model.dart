import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense_model.freezed.dart';
part 'expense_model.g.dart';

enum SplitType { equal, exact, percent, adjustment }

@freezed
sealed class SplitDetail with _$SplitDetail {
  const factory SplitDetail({
    required double amount,
    @Default('pending') String status, // pending, settled
  }) = _SplitDetail;

  factory SplitDetail.fromJson(Map<String, dynamic> json) =>
      _$SplitDetailFromJson(json);
}

enum TransactionType { income, expense }

@freezed
sealed class ExpenseModel with _$ExpenseModel {
  const factory ExpenseModel({
    required String id,
    required String title,
    @Default(TransactionType.expense) TransactionType type, // income, expense
    required double amount,
    @Default('INR') String currency,
    required int date, // Timestamp
    required String categoryId,
    required String categoryName,
    String? groupId,
    required String payerId,
    @Default(SplitType.equal) SplitType splitType,
    @Default([]) List<String> participants,
    @Default({}) Map<String, SplitDetail> splitDetails,
    required String createdBy,
    String? notes,
    String? receiptUrl,
  }) = _ExpenseModel;

  factory ExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseModelFromJson(json);
}
