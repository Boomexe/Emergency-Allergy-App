import 'package:dartz/dartz.dart';
import 'package:emergency_allergy_app/features/authentication/data/models/create_user_req.dart';
import 'package:emergency_allergy_app/features/authentication/data/models/signin_user_req.dart';
import 'package:emergency_allergy_app/features/authentication/data/sources/auth_firebase_service.dart';
import 'package:emergency_allergy_app/features/authentication/domain/auth_repository.dart';
import 'package:emergency_allergy_app/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    return await sl<AuthFirebaseServiceImpl>().signin(signinUserReq);
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    return await sl<AuthFirebaseServiceImpl>().signup(createUserReq);
  }

  @override
  Future<void> signout() async {
    return await sl<AuthFirebaseServiceImpl>().signout();
  }
}
