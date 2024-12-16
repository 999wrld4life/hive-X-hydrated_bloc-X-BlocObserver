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
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive X Hydrated Bloc'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter your task...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                context.read<TodoBloc>().add(AddTodo(_controller.text));
              },
              child: const Text('ADD'),
            ),
            const SizedBox(height: 20),
            BlocBuilder(
              builder: (context, state) {
                if (state is TodoLoading) {
                  const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TodoLoaded) {
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: state.todoList.length,
                    itemBuilder: (context, index) {
                      final task = state.todoList[index];
                      final isFavorite = state.todoList.contains(task);
                      return ListTile(
                        title: Text(
                          task,
                        ),
                        trailing: Row(
                          children: [
                            Expanded(
                              child: IconButton(
                                onPressed: () {
                                  context
                                      .read<TodoBloc>()
                                      .add(RemoveTodo(task));
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                onPressed: () {
                                  if (isFavorite) {
                                    context
                                        .read<TodoBloc>()
                                        .add(RemoveTodoFavorite(task));
                                  } else {
                                    context
                                        .read<TodoBloc>()
                                        .add(AddTodoFavorite(task));
                                  }
                                },
                                icon: isFavorite
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                    : const Icon(Icons.favorite_border),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                return const Center(
                  child: Text("No Task"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
