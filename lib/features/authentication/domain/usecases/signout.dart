import 'package:dartz/dartz.dart';
import 'package:emergency_allergy_app/core/usecase/usecase.dart';
import 'package:emergency_allergy_app/features/authentication/domain/auth_repository.dart';
import 'package:emergency_allergy_app/service_locator.dart';

class SignoutUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({dynamic? params}) {
    sl<AuthRepository>().signout();
    return Future.value(const Right('Signout successful'));
  }
}