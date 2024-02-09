import 'package:firebase_auth/firebase_auth.dart';
import 'package:sahem/Features/auth/data/user_model.dart';

abstract class AuthState {
  get userModel => null;
}

class AuthInitianState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthCodeSentState extends AuthState {}

class AuthCodeVerifiedState extends AuthState {}

class AuthLoggedInState extends AuthState {
  final User firebaseUser;
  final UserModel userModel;

  AuthLoggedInState(this.firebaseUser, this.userModel);
}

class AuthLoggedOutState extends AuthState {}

class AuthErrorState extends AuthState {
  final String error;
  AuthErrorState(this.error);
}
