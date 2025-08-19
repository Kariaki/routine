import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:routine/core/util/storage_keys.dart';

@lazySingleton
class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<bool> isLoggedIn() async {
    final result = await _storage.read(key: StorageKeys.userDetails);
    return result != null;
  }

  Future<String?> get(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<void> writeJson(String key, Map<String, dynamic> json) async {
    await write(key, jsonEncode(json));
  }

  Future<void> tearDown() async {
    await _storage.deleteAll();
  }
}
