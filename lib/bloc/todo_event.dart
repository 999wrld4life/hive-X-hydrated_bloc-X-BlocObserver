part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class AddTodo extends TodoEvent {
  final String task;
  const AddTodo(this.task);

  @override
  List<Object> get props => [task];
}

class RemoveTodo extends TodoEvent {}

class AddTodoFavorite extends TodoEvent {}

class RemoveTodoFavorite extends TodoEvent {}
