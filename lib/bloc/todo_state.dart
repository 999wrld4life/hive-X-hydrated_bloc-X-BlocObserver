part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<String> todoList;
  const TodoLoaded(this.todoList);

  @override
  List<Object> get props => [todoList];
}

class FavoriteAdded extends TodoState {
  final List<String> favoriteList;
  const FavoriteAdded(this.favoriteList);

  @override
  List<Object> get props => [favoriteList];
}

class FavoriteRemoved extends TodoState {}

class FavoriteError extends TodoState {}
