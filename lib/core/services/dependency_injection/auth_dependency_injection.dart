import 'package:e_commerce_with_firebase/core/services/auth_services.dart';
import 'package:e_commerce_with_firebase/core/services/database_service.dart';
import 'package:e_commerce_with_firebase/features/auth/data/repos/auth_repo.dart';
import 'package:e_commerce_with_firebase/features/auth/domain/repos/auth_base_repo.dart';
import 'package:e_commerce_with_firebase/features/auth/domain/use_cases/log_in_user_use_case.dart';
import 'package:e_commerce_with_firebase/features/auth/domain/use_cases/sign_up_user_use_case.dart';
import 'package:e_commerce_with_firebase/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

class AuthDependencyInjection {
  static void init() {
    getIt.registerFactory(() => AuthCubit(getIt(), getIt()));

    getIt.registerLazySingleton<SignUpUserUseCase>(
      () => SignUpUserUseCase(authBaseRepo: getIt()),
    );

    getIt.registerLazySingleton<LogInUserUseCase>(
        () => LogInUserUseCase(authBaseRepo: getIt()));

   

    getIt.registerLazySingleton<AuthServices>(
      () => FirebaseAuthServices(),
    );
 getIt.registerLazySingleton<DatabaseService>(() => DatabaseServiceImpl());
    getIt.registerLazySingleton<AuthBaseRepo>(
      () => AuthRepo(authServices: getIt(), databaseService: getIt()),
    );
  }
}
