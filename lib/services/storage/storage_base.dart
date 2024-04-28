import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageBase {
  static SharedPreferences? sharedPrefereces;
  static FlutterSecureStorage? secureStorage;
  static StorageBase? _instance;

  const StorageBase._();

  static StorageBase get instance {
    _instance ??= const StorageBase._();
    return _instance!;
  }

  Future<void> init() async {
    sharedPrefereces ??= await SharedPreferences.getInstance();
    secureStorage ??= const FlutterSecureStorage();
  }

  T? getCommonData<T>(String key) {
    try {
      if (T == String) {
        return sharedPrefereces!.getString(key) as T?;
      } else if (T == int) {
        return sharedPrefereces!.getInt(key) as T?;
      } else if (T == double) {
        return sharedPrefereces!.getDouble(key) as T?;
      } else if (T == bool) {
        return sharedPrefereces!.getBool(key) as T?;
      } else {
        return sharedPrefereces!.get(key) as T?;
      }
    } on Exception {
      return null;
    }
  }

  Future<String?> getSecureData(String key) async {
    try {
      return await secureStorage!.read(key: key);
    } on Exception {
      return Future<String?>.value(null);
    }
  }

  Future<bool> setCommonData<T>(String key, T value) async {
    try {
      if (T == String) {
        return await sharedPrefereces!.setString(key, value as String);
      } else if (T == int) {
        return await sharedPrefereces!.setInt(key, value as int);
      } else if (T == double) {
        return await sharedPrefereces!.setDouble(key, value as double);
      } else if (T == bool) {
        return await sharedPrefereces!.setBool(key, value as bool);
      } else {
        return await sharedPrefereces!.setString(key, value.toString());
      }
    } on Exception {
      return false;
    }
  }

  Future<bool> setSecureData(String key, String value) async {
    try {
      await secureStorage!.write(key: key, value: value);
      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> removeCommonDataByKey(String key) async {
    try {
      return await sharedPrefereces!.remove(key);
    } on Exception {
      return false;
    }
  }

  Future<bool> removeSecureDataByKey(String key) async {
    try {
      await secureStorage!.delete(key: key);
      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> clearCommonData() async {
    try {
      return await sharedPrefereces!.clear();
    } on Exception {
      return false;
    }
  }

  Future<bool> clearSecureData() async {
    try {
      await secureStorage!.deleteAll();
      return true;
    } on Exception {
      return false;
    }
  }
}
