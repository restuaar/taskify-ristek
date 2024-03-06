import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskify/home.dart';
import 'package:taskify/screens/splash_screen.dart';
import 'package:taskify/utils/database.dart';
import 'package:taskify/models/user.dart';
import 'package:taskify/providers/page.dart';
import 'package:taskify/providers/task_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await TaskDatabase.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    user = null;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PageProvider()),
        ChangeNotifierProvider(create: (context) => TaskProvider())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Taskify',
        home: SplashScreen(nextScreen: Home()),
      ),
    );
  }
}
