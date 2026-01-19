import 'package:equatable/equatable.dart';

class InviteModel extends Equatable {
  final String code;
  final String inviterId;
  final String dynamicLink;
  final DateTime expiresAt;
  final int maxUses;
  final int useCount;

  const InviteModel({
    required this.code,
    required this.inviterId,
    required this.dynamicLink,
    required this.expiresAt,
    this.maxUses = 10,
    this.useCount = 0,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);
  bool get isFull => useCount >= maxUses;

  @override
  List<Object?> get props => [
    code,
    inviterId,
    dynamicLink,
    expiresAt,
    maxUses,
    useCount,
  ];
}
