import 'package:dartz/dartz.dart';
import 'package:emergency_allergy_app/features/authentication/data/models/create_user_req.dart';
import 'package:emergency_allergy_app/features/authentication/data/models/signin_user_req.dart';

abstract class AuthRepository {
  Future<Either> signup(CreateUserReq createUserReq);
  Future<Either> signin(SigninUserReq signinUserReq);
  Future<void> signout();
}
