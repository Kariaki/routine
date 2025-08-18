import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:routine/dto/user_dto.dart';
import 'package:routine/entity/create_account_dto.dart';
import 'package:routine/entity/login_entity.dart';
import 'package:routine/util/result_wrapper.dart';
import 'package:routine/exception/app_exception.dart';

abstract class AuthRepository {
  Future<ApiResult<UserModel>> login(LoginEntity entity);

  Future<ApiResult<UserModel>> createAccount(CreateAccountEntity entity);

  Future<void> logout();
}

class FirebaseAuthRepository extends AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref("users");

  @override
  Future<ApiResult<UserModel>> createAccount(CreateAccountEntity entity) async {
    return ApiResultWrapper.wrap<UserModel>(
      func: () async {
        final result = await _auth.createUserWithEmailAndPassword(
          email: entity.email,
          password: entity.password,
        );
        final defaultUserId = DateTime.now().millisecondsSinceEpoch.toString();
        final reference = _database.child(result.user?.uid ?? defaultUserId);
        final user = entity.toUserModel(reference.key ?? defaultUserId);
        await reference.set(user.toJson());
        return user;
      },
    );
  }

  @override
  Future<ApiResult<UserModel>> login(LoginEntity entity) async {
    return ApiResultWrapper.wrap<UserModel>(
      func: () async {
        final result = await _auth.signInWithEmailAndPassword(
          email: entity.email,
          password: entity.password,
        );
        final defaultUserId = DateTime.now().millisecondsSinceEpoch.toString();
        final snapshot = await _database
            .child(result.user?.uid ?? defaultUserId)
            .get();
        if (snapshot.exists) {
          return UserModel.fromJson(snapshot.value as Map<dynamic, dynamic>);
        } else {
          throw AppException("User not found", statusCode: 404);
        }
      },
    );
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }

}
