import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/features/auth/data/repository/auth_repository_implementation.dart';
import 'package:to_do_app/features/auth/domain/repository/base_auth_repository.dart';


part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  final BaseAuthRepository base = AuthRepositoryImplementation();

  Future<void> signUpWithFirebase(String email, String password) async {
    emit(SignUpLoading());
    var res = await base.signUpWithFirebase(email, password);
    res.fold(
      ifLeft: (value) {
        print(value);
        emit(SignUpFailure(value));

      },
      ifRight: (value) {
        print(value);
        emit(SignUpSuccess());

      },
    );
  }
}
