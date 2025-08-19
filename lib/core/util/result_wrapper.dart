import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:routine/core/exception/app_exception.dart';

class ApiResultWrapper {
  ApiResultWrapper._();

  static Future<ApiResult<T>> wrap<T>({
    required Future<T> Function() func,

  }) async {
    try {
      final result = await func.call();
      return Success(data: result);
    }  on AppException catch(e){
      return Failure(error: e.message, code: e.statusCode);
    }
    on FirebaseAuthException catch (authError, trace) {
      print(authError.code);
      final message = _mapAuthError(authError.code, authError.message);
      return Failure(error: message, code: _mapAuthCode(authError.code));
    } on FirebaseException catch (fbError, trace) {
      final message = fbError.message ?? "Firebase error occurred";
      return Failure(error: message, code: _mapFirebaseCode(fbError.code));
    } catch (e, trace) {
      debugPrintStack(stackTrace: trace);
      return Failure(error: e.toString(), code: -1);
    }
  }

  /// Map common FirebaseAuth errors into human-readable messages
  static String _mapAuthError(String code, String? originalMessage) {
    switch (code) {
      case 'invalid-email':
        return "The email address is badly formatted.";
      case 'user-disabled':
        return "This user has been disabled.";
      case 'user-not-found':
        return "No user found with this email.";
      case 'wrong-password':
        return "Incorrect password. Please try again.";
      case 'invalid-credential':
        return "Incorrect credential.";
      case 'email-already-in-use':
        return "The email is already in use.";
      case 'weak-password':
        return "The password is too weak.";
      case 'operation-not-allowed':
        return "This operation is not allowed.";
      default:
        return originalMessage ?? "Authentication failed.";
    }
  }

  /// Assign numeric codes if you want structured error handling
  static int _mapAuthCode(String code) {
    switch (code) {
      case 'invalid-email':
        return 1001;
      case 'user-disabled':
        return 1002;
      case 'user-not-found':
        return 1003;
      case 'wrong-password':
        return 1004;
      case 'email-already-in-use':
        return 1005;
      case 'weak-password':
        return 1006;
      case 'operation-not-allowed':
        return 1007;
      default:
        return -1;
    }
  }

  /// Generic Firebase errors (Firestore, Database, Storage, etc.)
  static int _mapFirebaseCode(String code) {
    switch (code) {
      case 'permission-denied':
        return 2001;
      case 'unavailable':
        return 2002;
      case 'not-found':
        return 2003;
      default:
        return -1;
    }
  }
}

sealed class ApiResult<T> {
  const ApiResult();

  void when({
    required void Function(T) onSuccess,
    required void Function(String) onError,
  }) {
    final value = this;
    if (value is Success<T>) {
      onSuccess(value.data);
    }
    if (value is Failure<T>) {
      onError(value.error);
    }
  }
}

class Success<T> extends ApiResult<T> {
  final T data;

  const Success({required this.data});
}

class Failure<T> extends ApiResult<T> {
  final int? code;
  final String error;

  const Failure({required this.error, this.code});
}
