import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'add_to_do_state.dart';

class AddToDoCubit extends Cubit<AddToDoState> {
  AddToDoCubit() : super(AddToDoInitial());

  Future<void> addToDo(String title, String description, DateTime date) async {
    print("=== AddToDo START ===");
    print("Title: $title");
    print("Description: $description");
    print("Date: $date");
    print("Current user: ${FirebaseAuth.instance.currentUser?.uid}");
    
    emit(AddToDoLoading());
    
    try {
      // جرب الإضافة مباشرة بدون Repository أولاً
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print("User not authenticated");
        emit(AddToDoFailure("User not authenticated"));
        return;
      }
      
      print("Adding to Firestore...");
      final doc = await FirebaseFirestore.instance
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
      
      print("Document added with ID: ${doc.id}");
      emit(AddToDoSuccess());
      
    } catch (e) {
      print("Error adding todo: $e");
      emit(AddToDoFailure(e.toString()));
    }
  }
}








