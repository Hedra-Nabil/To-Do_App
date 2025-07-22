import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/features/auth/data/repository/auth_repository_implementation.dart';
import 'package:to_do_app/features/auth/domain/repository/base_auth_repository.dart';


part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final BaseAuthRepository base = AuthRepositoryImplementation();

  Future<void> signInWIthFirebase(String email, String password) async {
    var res = await base.loginWithFirebase(email, password);

    res.fold(ifLeft: (value) {
      print(value);
      emit(LoginFailure(value));
    }, ifRight: (value) {
      print(value);
      emit(LoginSuccess());
    },);
  }
}
