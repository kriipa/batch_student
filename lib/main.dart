import 'package:batch_student_objbox_api/app/app.dart';
import 'package:batch_student_objbox_api/state/objectbox_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'helper/objectbox.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Delete database
  //ObjectBoxInstance.deleteDatabase();
  ObjectBoxState.objectBoxInstance = await ObjectBoxInstance.init();
  // Load data from json file
  //LoadFromJsonRepositoryImpl().loadFromJson();
  // Disable landscape mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (value) => runApp(
      const MyApp(),
    ),
  );
}
