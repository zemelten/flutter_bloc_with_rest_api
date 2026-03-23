import 'package:get_it/get_it.dart';

import 'modules/auth_module.dart';
import 'modules/core_module.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  await initCoreModule(sl);
  initAuthModule(sl);
}
