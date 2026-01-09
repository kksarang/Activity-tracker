import 'package:activity/features/friends/domain/user_model.dart';
import 'package:equatable/equatable.dart';

class GroupModel extends Equatable {
  final String id;
  final String name;
  final List<UserModel> members;
  final double totalExpense;

  const GroupModel({
    required this.id,
    required this.name,
    required this.members,
    this.totalExpense = 0.0,
  });

  @override
  List<Object?> get props => [id, name, members, totalExpense];
}
