import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: const MyApp(),
    ),
  );
}