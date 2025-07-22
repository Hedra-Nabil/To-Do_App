part of 'update_to_do_cubit.dart';

@immutable
sealed class UpdateToDoState {}

final class UpdateToDoInitial extends UpdateToDoState {}

final class UpdateToDoLoading extends UpdateToDoState {}

final class UpdateToDoSuccess extends UpdateToDoState {}

final class UpdateToDoFailure extends UpdateToDoState {
  final String error;
  UpdateToDoFailure(this.error);
}