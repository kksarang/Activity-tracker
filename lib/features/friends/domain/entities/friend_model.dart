import 'package:equatable/equatable.dart';

enum FriendStatus { pending, accepted, blocked }

class FriendModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;
  final FriendStatus status;
  final DateTime? connectedAt;

  const FriendModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    this.status = FriendStatus.pending,
    this.connectedAt,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json) {
    return FriendModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatarUrl'] as String,
      status: FriendStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
      ),
      connectedAt: json['connectedAt'] != null
          ? DateTime.parse(json['connectedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
      'status': status.toString(),
      'connectedAt': connectedAt?.toIso8601String(),
    };
  }

  FriendModel copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
    FriendStatus? status,
    DateTime? connectedAt,
  }) {
    return FriendModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      status: status ?? this.status,
      connectedAt: connectedAt ?? this.connectedAt,
    );
  }

  @override
  List<Object?> get props => [id, name, email, avatarUrl, status, connectedAt];
}
