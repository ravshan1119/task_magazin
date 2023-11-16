import 'package:equatable/equatable.dart';
import 'package:task_magazin/src/data/api_status.dart';
import 'package:task_magazin/src/domain/models/user_model.dart';

class UserState extends Equatable {
  final ApiStatus status;
  final List<UserModel> users;
  final String error;

  const UserState(
      {required this.status,
      required this.users,
      required this.error,
      });

  factory UserState.initial() {
    return const UserState(
      status: ApiStatus.initial,
      users: [],
      error: "",
    );
  }

  @override
  List<Object?> get props => [status, users, error];

  @override
  bool get stringify => true;

  UserState copyWith({
    ApiStatus? status,
    List<UserModel>? users,
    String? error,
  }) {
    return UserState(
      status: status ?? this.status,
      users: users ?? this.users,
      error: error ?? this.error,
    );
  }
}
