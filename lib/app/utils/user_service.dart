import 'package:get_storage/get_storage.dart';

class UserService {
  static final storage = GetStorage('emp');

  static bool clearBox() {
    try {
      storage.remove('emp');
      storage.erase();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static bool existUser() {
    return storage.read('auth') != null;
  }

  static String getToken() {
    if (existUser()) {
      return storage.read<Map<String, dynamic>>('auth')?['access_token'] ?? '';
    }
    return "";
  }

  static int getUserId() {
    if (existUser()) {
      return storage.read<Map<String, dynamic>>('auth')?['user']?['id'] ?? 0;
    }
    return 0;
  }

  static String getUserName() {
    if (existUser()) {
      return storage.read<Map<String, dynamic>>('auth')?['user']?['name'] ?? '';
    }
    return "";
  }

  static String getUserLogin() {
    if (existUser()) {
      return storage.read<Map<String, dynamic>>('auth')?['user']?['username'] ??
          '';
    }
    return "";
  }
}
