// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taskify/home.dart';
import 'package:taskify/providers/page.dart';
import 'package:taskify/providers/task_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var box = await Hive.openBox('taskify');

  box.put('name', 'David');

  print('Name: ${box.get('name')}');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PageProvider()),
        ChangeNotifierProvider(create: (context) => TaskProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Taskify',
        home: const Home(),
      ),
    );
  }
}
