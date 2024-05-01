import 'dart:convert';

import 'package:final_project/models/auth/user/user_model.dart';
import 'package:final_project/providers/states/auth_state.dart';
import 'package:final_project/services/storage/storage_base.dart';

class AuthStorageService {
  static const _tokenKey = 'tokenKey';
  static const _isAuthenticatedKey = 'isAuthenticatedKey';
  static const _userKey = 'authUserKey';
  final _storage = StorageBase.instance;

  UserModel? get user {
    final userString = _storage.getCommonData<String>(_userKey);
    if (userString != null) {
      return UserModel.fromJson(jsonDecode(userString) as Map<String, dynamic>);
    }
    return null;
  }

  Future<String?> get token {
    return _storage.getSecureData(_tokenKey);
  }

  bool get isAuthenticated {
    return _storage.getCommonData<bool>(_isAuthenticatedKey) ?? false;
  }

  void saveUser(UserModel user) {
    _storage.setCommonData<String>(_userKey, jsonEncode(user.toJson()));
  }

  void saveToken(String token) async {
    _storage.setSecureData(_tokenKey, token);
  }

  void saveState(AuthState state) {
    if (state is AUTHENTICATED) {
      _storage.setCommonData<bool>(_isAuthenticatedKey, true);
    }
  }

  void resetKeys() async {
    _storage.removeCommonDataByKey(_isAuthenticatedKey);
    _storage.removeCommonDataByKey(_userKey);
    _storage.removeSecureDataByKey(_tokenKey);
  }
}
