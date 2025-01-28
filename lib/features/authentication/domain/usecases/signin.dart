import 'package:dartz/dartz.dart';
import 'package:emergency_allergy_app/core/usecase/usecase.dart';
import 'package:emergency_allergy_app/features/authentication/data/models/signin_user_req.dart';
import 'package:emergency_allergy_app/features/authentication/domain/auth_repository.dart';
import 'package:emergency_allergy_app/service_locator.dart';

class SigninUseCase implements UseCase<Either, SigninUserReq> {
  @override
  Future<Either> call({SigninUserReq? params}) {
    return sl<AuthRepository>().signin(params!);
  }
}
