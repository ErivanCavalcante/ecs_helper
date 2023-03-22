import 'dart:async';
import 'package:ecs_helper/ecs_helper.dart';

class UserLoggedGuard extends RouteGuard {
  UserLoggedGuard(String redirectTo) : super(redirectTo: redirectTo);

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    if (!await UserUtil.isTokenExpired()) {
      return true;
    }

    await UserUtil.logout();
    return false;
  }
}
