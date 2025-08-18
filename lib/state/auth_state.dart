import 'package:routine/dto/user_dto.dart';

sealed class AuthState{

}
class AuthSuccess extends AuthState{
  UserModel user;
   AuthSuccess(this.user);
}

class LogoutSuccess extends AuthState{}