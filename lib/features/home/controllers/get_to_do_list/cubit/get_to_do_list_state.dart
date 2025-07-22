part of 'get_to_do_list_cubit.dart';

@immutable
sealed class GetToDoListState {}

final class GetToDoListInitial extends GetToDoListState {}




final class GetTodoInitial extends GetToDoListState {}

final class GetTodoLoading extends GetToDoListState {}

final class GetTodoFailure extends GetToDoListState {
  final String message;

  GetTodoFailure(this.message);
}

final class GetTodoSuccess extends GetToDoListState {
  final List<ToDoModel> todos;

  GetTodoSuccess(this.todos);
}
