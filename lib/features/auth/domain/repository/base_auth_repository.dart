import 'package:dart_either/dart_either.dart';

abstract class BaseAuthRepository{
  Future<Either> signUpWithFirebase(String email, String password) ;
  Future<Either> loginWithFirebase(String email, String password) ;

}