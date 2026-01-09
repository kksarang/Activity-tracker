import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String avatarUrl;
  final String? email;

  const UserModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
    this.email,
  });

  @override
  List<Object?> get props => [id, name, avatarUrl, email];

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String,
      email: json['email'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'avatarUrl': avatarUrl, 'email': email};
  }
}
