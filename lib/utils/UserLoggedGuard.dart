import 'dart:async';
import 'package:ecs_helper/ecs_helper.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UserLoggedGuard extends RouteGuard {
  UserLoggedGuard(String redirectTo) : super(redirectTo: redirectTo);

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    if (!UserUtil.isTokenExpired()) {
      return true;
    }

    await UserUtil.logout();
    return false;
  }
}
