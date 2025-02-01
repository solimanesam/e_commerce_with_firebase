part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final RequestStateEnum? signInStateEnum;
  final String signInMessage;
  final RequestStateEnum? signUpStateEnum;

  final String signUpMessage;
  const AuthState(
      {this.signUpStateEnum,
      this.signUpMessage = '',
      this.signInStateEnum,
      this.signInMessage = ''});

  @override
  List<Object?> get props =>
      [signInStateEnum, signInMessage, signUpStateEnum, signUpMessage];
}
