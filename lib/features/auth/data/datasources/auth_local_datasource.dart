import 'package:get_storage/get_storage.dart';
import '../../domain/entities/user.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(User user);
  User? getCachedUser();
  Future<void> clearCache();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String _userKey = 'cached_user';
  final GetStorage _storage;

  AuthLocalDataSourceImpl({GetStorage? storage})
    : _storage = storage ?? GetStorage();

  @override
  Future<void> cacheUser(User user) async {
    final userModel = UserModel.fromEntity(user);
    await _storage.write(_userKey, userModel.toJson());
  }

  @override
  User? getCachedUser() {
    final userJson = _storage.read<Map<String, dynamic>>(_userKey);
    if (userJson == null) return null;

    try {
      return UserModel.fromJson(userJson);
    } catch (e) {
      // If deserialization fails, clear corrupted cache synchronously
      _storage.remove(_userKey);
      return null;
    }
  }

  @override
  Future<void> clearCache() async {
    await _storage.remove(_userKey);
  }
}
