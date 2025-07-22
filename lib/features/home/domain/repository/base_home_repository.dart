import 'package:dart_either/dart_either.dart';

abstract class BaseHomeRepository {
  Future<Either> addToDo(String title, String description, DateTime date);
  Future<Either> gettodolist();
}
