import 'package:routine/dto/user_dto.dart';

class CreateAccountEntity{
  final String fullname;
  final String email;
  final String password;

  const CreateAccountEntity({
    required this.fullname,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullname,
      'email': email,
      'password': password,
    };
  }

  UserModel toUserModel(String userId){
    return UserModel(email: email, fullname: fullname, createdAt: DateTime.now(), userId: userId);
  }
}