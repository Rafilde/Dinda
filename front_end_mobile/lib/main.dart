import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:front_end_mobile/shared/locator.dart';
import 'app_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Locator.setup();
  runApp(const AppScreen());
}