library ecs_helper;

import 'package:get_storage/get_storage.dart';

export 'package:ecs_helper/components/EcsSpacerSmall.dart' show EcsSpacerSmall;
export 'package:ecs_helper/components/EcsSpacerMedium.dart'
    show EcsSpacerMedium;
export 'package:ecs_helper/components/EcsSpacerLarge.dart' show EcsSpacerLarge;
export 'package:ecs_helper/components/EcsSideMenu.dart';
export 'package:ecs_helper/components/EcsUrlSideMenu.dart';
export 'package:ecs_helper/components/EcsTextField.dart' show EcsTextField;
export 'package:ecs_helper/components/EcsBlockButton.dart' show EcsBlockButton;
export 'package:ecs_helper/components/EcsLoadingBarrier.dart'
    show EcsLoadingBarrier;
export 'package:reactive_forms/reactive_forms.dart';
export 'package:flutter_modular/flutter_modular.dart';

export 'package:ecs_helper/utils/UserUtil.dart' show UserUtil;
export 'package:ecs_helper/utils/UserLoggedGuard.dart' show UserLoggedGuard;

class EcsHelper {
  Future init() async {
    await GetStorage.init();
  }
}
