import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_x_hydrated_bloc_x_bloc_observer/bloc/todo_bloc.dart';
import 'package:hive_x_hydrated_bloc_x_bloc_observer/repository/hive_repo.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('todo');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(HiveRepo()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive X Hydrated Bloc'),
      ),
      body: const SafeArea(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter your task...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
