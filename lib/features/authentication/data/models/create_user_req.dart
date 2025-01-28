class CreateUserReq {
  String displayName;
  String email;
  String password;

  CreateUserReq({
    required this.displayName,
    required this.email,
    required this.password,
  });
}