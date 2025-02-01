import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String name;
  final String email;
  final String uId;

  const UserEntity(
      {required this.name, required this.email, required this.uId});

  @override
  List<Object?> get props => [name, email, uId];
}
