class AuthInputModel {
  final String email;
  final String password;
  final String? name;

  AuthInputModel({this.name, required this.email, required this.password});
}
