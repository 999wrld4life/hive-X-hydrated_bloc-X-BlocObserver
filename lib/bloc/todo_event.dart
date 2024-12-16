part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class FetchTodo extends TodoEvent {
  final List<String> todos;
  const FetchTodo(this.todos);

  @override
  List<Object> get props => [todos];
}

class AddTodo extends TodoEvent {
  final String task;
  const AddTodo(this.task);

  @override
  List<Object> get props => [task];
}

class RemoveTodo extends TodoEvent {
  final String task;
  const RemoveTodo(this.task);

  @override
  List<Object> get props => [task];
}

class FetchFavorites extends TodoEvent {
  final List<String> todos;
  const FetchFavorites(this.todos);

  @override
  List<Object> get props => [todos];
}

class AddTodoFavorite extends TodoEvent {
  final String task;
  const AddTodoFavorite(this.task);

  @override
  List<Object> get props => [task];
}

class RemoveTodoFavorite extends TodoEvent {
  final String task;
  const RemoveTodoFavorite(this.task);

  @override
  List<Object> get props => [task];
}
