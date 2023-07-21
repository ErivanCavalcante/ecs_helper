library ecs_helper;

import 'package:shared_preferences/shared_preferences.dart';

export 'package:ecs_helper/components/EcsSpacer.dart' show EcsSpacer;
export 'package:ecs_helper/components/EcsSideMenu.dart';
export 'package:ecs_helper/components/EcsUrlSideMenu.dart';
export 'package:ecs_helper/components/EcsTextField.dart' show EcsTextField;
export 'package:ecs_helper/components/EcsBlockButton.dart' show EcsBlockButton;
export 'package:ecs_helper/components/EcsLoadingBarrier.dart'
    show EcsLoadingBarrier;
export 'package:ecs_helper/utils/UserUtil.dart' show UserUtil;
export 'package:ecs_helper/utils/UserLoggedGuard.dart' show UserLoggedGuard;

class EcsHelper {
  static late SharedPreferences preferences;

  static Future init() async {
    preferences = await SharedPreferences.getInstance();
  }
}
