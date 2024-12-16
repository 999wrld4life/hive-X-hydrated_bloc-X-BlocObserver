import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_x_hydrated_bloc_x_bloc_observer/repository/hive_repo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final HiveRepo hiveRepository;
  TodoBloc(this.hiveRepository) : super(TodoInitial()) {
    on<FetchTodo>(
      (event, emit) {
        emit(TodoLoading());
        try {
          final todoList = hiveRepository.getTodo();
          emit(TodoLoaded(todoList));
        } catch (e) {
          log(e.toString());
        }
      },
    );
    on<AddTodo>((event, emit) {
      emit(TodoLoading());
      try {
        hiveRepository.addTodo(event.task);
        final currentTodos = hiveRepository.getTodo();
        emit(TodoLoaded(currentTodos));
      } catch (e) {
        log(e.toString());
      }
    });
    on<RemoveTodo>(
      (event, emit) {
        emit(TodoLoading());
        try {
          hiveRepository.removeTodo(event.task);
          final currentTodos = hiveRepository.getTodo();
          emit(TodoLoaded(currentTodos));
        } catch (e) {
          log(e.toString());
        }
      },
    );
    on<FetchFavorites>(
      (event, emit) {
        emit(TodoLoading());
        try {
          final favoriteList = hiveRepository.getFavorites();
          emit(TodoLoaded(favoriteList));
        } catch (e) {
          log(e.toString());
        }
      },
    );

    on<AddTodoFavorite>(
      (event, emit) {
        emit(TodoLoading());
        try {
          hiveRepository.addToFavorite(event.task);
          final currentTodos = hiveRepository.getTodo();
          emit(TodoLoaded(currentTodos));
        } catch (e) {
          log(e.toString());
        }
      },
    );
    on<RemoveTodoFavorite>(
      (event, emit) {
        emit(TodoLoading());
        try {
          hiveRepository.removeFromFavorites(event.task);
          final currentTodos = hiveRepository.getTodo();
          emit(TodoLoaded(currentTodos));
        } catch (e) {
          log(e.toString());
        }
      },
    );
  }
}
