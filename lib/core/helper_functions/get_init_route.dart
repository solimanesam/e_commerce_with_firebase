import 'package:e_commerce_with_firebase/core/services/cache_service.dart';
import 'package:e_commerce_with_firebase/core/services/dependency_injection/dependency_injection.dart';

String get getInitRoute {
  final String? uId = getIt<BaseCacheService>().getStringFromCache(key: "uId");
  final String? uName =
      getIt<BaseCacheService>().getStringFromCache(key: "name");

  return uId == null
      ? 'login'
      : uName != "admin"
          ? 'dashboard'
          : 'adminhome';
}
