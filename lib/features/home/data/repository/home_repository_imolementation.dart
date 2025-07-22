import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_either/dart_either.dart';
import 'package:to_do_app/features/home/data/models/to_do_model.dart';
import 'package:to_do_app/features/home/domain/repository/base_home_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeRepositoryImolementation extends BaseHomeRepository {
  final instance = FirebaseFirestore.instance;
  @override
  Future<Either<String, DocumentReference>> addToDo(
    String title,
    String description,
    DateTime date,
  ) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return Left('User not authenticated');
      }
      
      print('Date being sent: $date');
      print('Timestamp: ${Timestamp.fromDate(date)}');
      
      final document = await instance
          .collection('users')
          .doc(user.uid)
          .collection('todos')
          .add({
        'title': title,
        'description': description,
        'date': Timestamp.fromDate(date),
        'completed': false,
        'createdAt': Timestamp.now(),
      });
      
      print('Document added with ID: ${document.id}');
      return Right(document);
    } catch (e) {
      print('Firestore Error: $e');
      return Left(e.toString());
    }
  }
  
  @override
  Future<Either> gettodolist() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return Left('User not authenticated');
      }
      
      final snapshot = await instance
          .collection('users')
          .doc(user.uid)
          .collection('todos')
          .orderBy('createdAt', descending: true)
          .get();
      
      final todos = snapshot.docs.map((doc) {
        return ToDoModel.fromMap(doc.data(), doc.id);
      }).toList();
      return Right(todos);
    } catch (e) {
      print("Firestore Error: $e");
      return Left(e.toString());
    }
  }
}
