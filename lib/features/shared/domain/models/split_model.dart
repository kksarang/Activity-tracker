import 'package:freezed_annotation/freezed_annotation.dart';

part 'split_model.freezed.dart';
part 'split_model.g.dart';

@freezed
sealed class SplitModel with _$SplitModel {
  const factory SplitModel({
    required String id,
    required String title,
    required double totalAmount,
    required String createdBy,
    required List<SplitParticipant> participants,
    @Default(SplitStatus.pending) SplitStatus status,
    required DateTime createdAt,
  }) = _SplitModel;

  factory SplitModel.fromJson(Map<String, dynamic> json) =>
      _$SplitModelFromJson(json);
}

@freezed
sealed class SplitParticipant with _$SplitParticipant {
  const factory SplitParticipant({
    required String userId,
    required double share,
    @Default(false) bool hasPaid,
  }) = _SplitParticipant;

  factory SplitParticipant.fromJson(Map<String, dynamic> json) =>
      _$SplitParticipantFromJson(json);
}

enum SplitStatus { pending, partial, completed }
