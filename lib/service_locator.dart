import 'package:emergency_allergy_app/features/authentication/data/auth_repository_impl.dart';
import 'package:emergency_allergy_app/features/authentication/data/sources/auth_firebase_service.dart';
import 'package:emergency_allergy_app/features/authentication/domain/auth_repository.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl(),
  );

  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(),
  );
}