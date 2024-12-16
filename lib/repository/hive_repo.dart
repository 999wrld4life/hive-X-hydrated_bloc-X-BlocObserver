import 'package:hive/hive.dart';

class HiveRepo {
  final hiveBox = Hive.box('todo');

  List<String> getTodo() {
    return (hiveBox.get('todoList') ?? []).cast<String>();
  }

  void addTodo(String task) {
    final currentTodo = getTodo();
    if (!currentTodo.contains(task)) {
      currentTodo.add(task);
    }
    hiveBox.put('todoList', currentTodo);
  }

  void removeTodo(String task) {
    final currentTodo = getTodo();
    currentTodo.remove(task);
    hiveBox.put('todoList', currentTodo);
  }

  List<String> getFavorites() {
    return (hiveBox.get('favoritesList') ?? []).cast<String>();
  }

  void addToFavorite(String task) {
    final currentFavorites = getFavorites();
    if (!currentFavorites.contains(task)) {
      currentFavorites.add(task);
      hiveBox.put('favoritesList', currentFavorites);
    }
  }

  void removeFromFavorites(String task) {
    final currentFavorites = getFavorites();
    if (currentFavorites.contains(task)) {
      currentFavorites.remove(task);
    }
    hiveBox.put('favoritesList', currentFavorites);
  }
}
