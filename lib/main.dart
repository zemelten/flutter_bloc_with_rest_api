import 'package:flutter/material.dart';

import 'config/app.dart';
import 'injection/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const App());
}
