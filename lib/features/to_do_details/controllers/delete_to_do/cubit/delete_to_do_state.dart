part of 'delete_to_do_cubit.dart';

@immutable
sealed class DeleteToDoState {}

final class DeleteToDoInitial extends DeleteToDoState {}

final class DeleteToDoLoading extends DeleteToDoState {}

final class DeleteToDoSuccess extends DeleteToDoState {}

final class DeleteToDoFailure extends DeleteToDoState {
  final String error;
  DeleteToDoFailure(this.error);
}