import 'package:flutter/material.dart';
import 'package:mass_communication/navigation/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/firebase_options.dart';
import 'core/user_preference.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();  // Ensure all bindings are initialized
  await Firebase.initializeApp(              // Initialize Firebase with options
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await UserPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mass Communication App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: AppRoutes.generateRoute, // Route generation
    );
  }
}
