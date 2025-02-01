import 'package:dartz/dartz.dart';
import 'package:e_commerce_with_firebase/core/errors/failures.dart';
import 'package:e_commerce_with_firebase/core/models/auth_input_model.dart';
import 'package:e_commerce_with_firebase/core/utils/base_use_case.dart';
import 'package:e_commerce_with_firebase/features/auth/domain/repos/auth_base_repo.dart';

class SignUpUserUseCase
    extends BaseUseCaseWithParameters<Unit, AuthInputModel> {
  final AuthBaseRepo authBaseRepo;

  SignUpUserUseCase({required this.authBaseRepo});
  @override
  Future<Either<Failure, Unit>> call(
      {required AuthInputModel parameters}) async {
    return await authBaseRepo.signUpUser(authInputModel: parameters);
  }
}
