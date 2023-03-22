import 'package:shared_preferences/shared_preferences.dart';

class UserUtil {
  static Future<bool> isUserLogged() async {
    final preference = await SharedPreferences.getInstance();

    return preference.getString('user_id') != null;
  }

  static Future<bool> isTokenExpired() async {
    if (!await UserUtil.isUserLogged()) {
      return true;
    }

    final preference = await SharedPreferences.getInstance();

    final expires = preference.getInt('expires');
    final currentDate = DateTime.now();

    if (expires == null) {
      return true;
    }

    if (currentDate.millisecondsSinceEpoch > expires) {
      return true;
    }

    return false;
  }

  static Future logout() async {
    final preference = await SharedPreferences.getInstance();
    preference.clear();
  }

  static Future login({
    required String userId,
    required String email,
    required String token,
    required DateTime expires,
    String? name,
    String? role,
    String? cargo,
  }) async {
    final preference = await SharedPreferences.getInstance();

    preference.setString('user_id', userId);
    preference.setString('email', email);
    preference.setString('token', token);
    preference.setInt('expires', expires.millisecondsSinceEpoch);

    if (name != null) {
      preference.setString('name', name);
    }

    if (role != null) {
      preference.setString('role', role);
    }

    if (cargo != null) {
      preference.setString('cargo', cargo);
    }
  }

  static Future<Map<String, dynamic>> getUserData() async {
    final preference = await SharedPreferences.getInstance();

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
      if (preference.containsKey(key)) {
        data[key] = preference.get(key);
      }
    }

    return data;
  }
}
