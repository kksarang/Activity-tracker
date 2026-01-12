import 'package:freezed_annotation/freezed_annotation.dart';

part 'settlement_model.freezed.dart';
part 'settlement_model.g.dart';

@freezed
sealed class SettlementModel with _$SettlementModel {
  const factory SettlementModel({
    required String id,
    required String payerId,
    required String receiverId,
    required double amount,
    String? groupId,
    required int date, // Timestamp
    @Default('CASH') String method, // CASH, UPI, etc.
  }) = _SettlementModel;

  factory SettlementModel.fromJson(Map<String, dynamic> json) =>
      _$SettlementModelFromJson(json);
}
