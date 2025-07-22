import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'update_to_do_state.dart';

class UpdateToDoCubit extends Cubit<UpdateToDoState> {
  UpdateToDoCubit() : super(UpdateToDoInitial());

  Future<void> updateToDo(String todoId, String title, String description, DateTime date) async {
    emit(UpdateToDoLoading());
    
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(UpdateToDoFailure("User not authenticated"));
        return;
      }
      
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('todos')
          .doc(todoId)
          .update({
        'title': title,
        'description': description,
        'date': Timestamp.fromDate(date),
        'updatedAt': Timestamp.now(),
      });
      
      emit(UpdateToDoSuccess());
      
    } catch (e) {
      emit(UpdateToDoFailure(e.toString()));
    }
  }
}