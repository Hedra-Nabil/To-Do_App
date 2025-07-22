import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/features/home/data/models/to_do_model.dart';
import 'package:to_do_app/features/home/data/repository/home_repository_imolementation.dart';
import 'package:to_do_app/features/home/domain/repository/base_home_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

part 'get_to_do_list_state.dart';

class GetToDoListCubit extends Cubit<GetToDoListState> {
  GetToDoListCubit() : super(GetToDoListInitial());
  BaseHomeRepository baseHomeRepository = HomeRepositoryImolementation();

  Future<void> getTodoList() async {
    emit(GetTodoLoading());
    var res = await baseHomeRepository.gettodolist();
    res.fold(
      ifLeft: (value) {
        emit(GetTodoFailure(value));
      },
      ifRight: (value) {
        emit(GetTodoSuccess(value));
      },
    );
  }

  void _cacheToDoList(List<Map<String, dynamic>> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = todos.map((todo) => jsonEncode(todo)).toList();
    await prefs.setStringList('cached_todos', todosJson);
  }

  Future<List<Map<String, dynamic>>> _getCachedToDoList() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedTodos = prefs.getStringList('cached_todos') ?? [];
    return cachedTodos.map((todo) => jsonDecode(todo) as Map<String, dynamic>).toList();
  }
}

