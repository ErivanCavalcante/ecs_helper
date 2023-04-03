import 'package:ecs_helper/ecs_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserUtil {
  static bool isUserLogged() {
    final box = EcsHelper.preferences;

    return box.getString('email') != null;
  }

  static bool isTokenExpired() {
    if (!UserUtil.isUserLogged()) {
      return true;
    }

    final box = EcsHelper.preferences;

    final int? expires = box.getInt('expires');
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
    final box = EcsHelper.preferences;

    return box.getString('token');
  }

  static String? readUserId() {
    final box = EcsHelper.preferences;

    return box.getString('id');
  }

  static Future logout() async {
    final box = await SharedPreferences.getInstance();
    await box.clear();
  }

  static void login({
    required String id,
    required String userName,
    required String email,
    required String token,
    required DateTime expires,
    String? name,
    String? role,
    String? cargo,
  }) {
    final box = EcsHelper.preferences;

    box.setString('id', id);
    box.setString('email', email);
    box.setString('userName', userName);
    box.setString('token', token);
    box.setInt('expires', expires.millisecondsSinceEpoch);

    if (name != null) {
      box.setString('name', name);
    }

    if (role != null) {
      box.setString('role', role);
    }

    if (cargo != null) {
      box.setString('cargo', cargo);
    }
  }

  static Map<String, dynamic> readUserData() {
    final box = EcsHelper.preferences;

    final keys = <String>[
      'id',
      'userName',
      'email',
      'token',
      'expires',
      'name',
      'role',
      'cargo',
    ];

    Map<String, dynamic> data = {};

    for (var key in keys) {
      var value = box.get(key);

      if (value != null) {
        data[key] = value;
      }
    }

    return data;
  }
}
