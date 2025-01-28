import 'package:dartz/dartz.dart';
import 'package:emergency_allergy_app/core/usecase/usecase.dart';
import 'package:emergency_allergy_app/features/authentication/data/models/create_user_req.dart';
import 'package:emergency_allergy_app/features/authentication/domain/auth_repository.dart';
import 'package:emergency_allergy_app/service_locator.dart';

class SignupUseCase implements UseCase<Either, CreateUserReq> {
  @override
  Future<Either> call({CreateUserReq? params}) {
    return sl<AuthRepository>().signup(params!);
  }
}