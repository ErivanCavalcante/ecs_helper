import 'package:get_storage/get_storage.dart';

class UserUtil {
  static bool isUserLogged() {
    final box = GetStorage();

    return box.read('user_id') != null;
  }

  static bool isTokenExpired() {
    if (!UserUtil.isUserLogged()) {
      return true;
    }

    final box = GetStorage();

    final int? expires = box.read('expires');
    final currentDate = DateTime.now();

    if (expires == null) {
      return true;
    }

    if (currentDate.millisecondsSinceEpoch > expires) {
      return true;
    }

    return false;
  }

  static String? readToken() {
    final box = GetStorage();

    return box.read('token');
  }

  static Future logout() async {
    final box = GetStorage();
    await box.erase();
  }

  static void login({
    required String userId,
    required String email,
    required String token,
    required DateTime expires,
    String? name,
    String? role,
    String? cargo,
  }) {
    final box = GetStorage();

    box.write('user_id', userId);
    box.write('email', email);
    box.write('token', token);
    box.write('expires', expires.millisecondsSinceEpoch);

    if (name != null) {
      box.write('name', name);
    }

    if (role != null) {
      box.write('role', role);
    }

    if (cargo != null) {
      box.write('cargo', cargo);
    }
  }

  static Map<String, dynamic> readUserData() {
    final box = GetStorage();

    final keys = <String>[
      'user_id',
      'email',
      'token',
      'expires',
      'name',
      'role',
      'cargo',
    ];

    Map<String, dynamic> data = {};

    for (var key in keys) {
      var value = box.read(key);

      if (value != null) {
        data[key] = value;
      }
    }

    return data;
  }
}
