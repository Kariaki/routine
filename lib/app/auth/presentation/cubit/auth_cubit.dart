import 'dart:convert';
import 'package:routine/app/auth/domain/entity/create_account_dto.dart';
import 'package:routine/app/auth/domain/repositories/auth_repository.dart';
import 'package:routine/core/util/base_cubit.dart';
import 'package:routine/core/util/cubit_state.dart';
import 'package:routine/core/util/storage_keys.dart';
import 'package:routine/src/di/injectable.dart';
import 'package:routine/src/service/secured_storage_service.dart';
import 'package:routine/app/auth/data/dto/user_dto.dart';
import 'package:routine/app/auth/domain/entity/login_entity.dart';

class AuthCubit extends BaseCubit<UserModel> {
  AuthCubit() : super(InitialState()) {
    _storageService = getIt<SecureStorageService>();
    _initialize();
  }

  _initialize() async {
    final result = await _storageService.get(StorageKeys.userDetails);
    if (result != null) {
      emitSuccess(data: (UserModel.fromJson(jsonDecode(result))));
    }
  }

  late SecureStorageService _storageService;
  final AuthRepository _repository = FirebaseAuthRepository();

  Future<void> createAccount(CreateAccountEntity entity) async {
    emitLoading();
    final response = await _repository.createAccount(entity);
    response.when(
      onSuccess: (result) {
        _storageService.writeJson(StorageKeys.userDetails, result.toJson());
        emitSuccess(data: (result));
      },
      onError: (error) {
        emitError(error);
      },
    );
  }

  Future<void> login(LoginEntity entity) async {
    emitLoading();
    final response = await _repository.login(entity);
    response.when(
      onSuccess: (result) {
        _storageService.writeJson(StorageKeys.userDetails, result.toJson());
        emitSuccess(data: (result));
      },
      onError: (error) {
        emitError(error);
      },
    );
  }

  Future<void> logout() async {
    await _repository.logout();
    await _storageService.tearDown();
    emitInitial(null);
  }
}
