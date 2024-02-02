import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahem/Features/auth/data/user_model.dart';
import 'package:sahem/Features/auth/manger/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? username;

  AuthCubit() : super(AuthInitianState());

  String? verificationID;

  void sendOTP(String phoneNumber, String userName) async {
    emit(AuthLoadingState());
    username = userName;
    _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeSent: (verificationId, forceResendingToken) {
        verificationID = verificationId;
        emit(AuthCodeSentState());
      },
      verificationCompleted: (phoneAuthCredential) {
        signInWithPhone(phoneAuthCredential);
      },
      verificationFailed: (error) {
        emit(AuthErrorState(error.message.toString()));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        verificationID = verificationId;
      },
    );
  }

  void verifyOTP(String otp) async {
    emit(AuthLoadingState());

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID!, smsCode: otp);
    signInWithPhone(credential);
  }

  void signInWithPhone(AuthCredential credential) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      if (userCredential.user != null) {
        UserModel userModel = UserModel(
          id: userCredential.user!.uid,
          phoneNumber: userCredential.user!.phoneNumber!,
          username: username!,
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(userModel.toFirestore());

        emit(AuthLoggedInState(userCredential.user!, userModel));
      }
    } on FirebaseAuthException catch (ex) {
      emit(AuthErrorState(ex.message.toString()));
    }
  }

  void logOut() async {
    emit(AuthLoggedOutState());
    _firebaseAuth.signOut();
  }
}
