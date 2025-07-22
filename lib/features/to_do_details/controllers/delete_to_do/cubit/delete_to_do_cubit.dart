import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'delete_to_do_state.dart';

class DeleteToDoCubit extends Cubit<DeleteToDoState> {
  DeleteToDoCubit() : super(DeleteToDoInitial());

  Future<void> deleteToDo(String todoId) async {
    emit(DeleteToDoLoading());
    
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(DeleteToDoFailure("User not authenticated"));
        return;
      }
      
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('todos')
          .doc(todoId)
          .delete();
      
      emit(DeleteToDoSuccess());
      
    } catch (e) {
      emit(DeleteToDoFailure(e.toString()));
    }
  }
}