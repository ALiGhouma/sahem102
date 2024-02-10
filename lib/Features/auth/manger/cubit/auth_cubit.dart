import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahem/Features/auth/data/user_model.dart';
import 'package:sahem/Features/auth/manger/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? username;
  // UserModel currentUser = authCubit.getCurrentUser();

  AuthCubit() : super(AuthInitianState());

  String? verificationID;

  static get authCubit => null;

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
        saveCurrentUserData();
        emit(AuthLoggedInState(userCredential.user!, userModel));
      }
    } on FirebaseAuthException catch (ex) {
      emit(AuthErrorState(ex.message.toString()));
    }
  }

  // helper funchin remmber if used loged in when close app
  // Future<bool> isUserLoggedIn() async {
  //   final user = _firebaseAuth.currentUser;
  //   return user != null;
  // }

  // void logOut() async {
  //   emit(AuthLoggedOutState());
  //   _firebaseAuth.signOut();
  // }

// Access current user information
  // UserInformation? getCurrentUser() {
  //   final User? currentUser = _firebaseAuth.currentUser;
  //   if (currentUser != null) {
  //     return UserInformation(
  //       uid: currentUser.uid,
  //       phoneNumber: currentUser.phoneNumber,
  //     );
  //   } else {
  //     return null;
  //   }
  // }

//  // helper funchin remmber to saveCurrentUserData
  void saveCurrentUserData() async {
    final user = _firebaseAuth.currentUser;

    if (user != null) {
      UserModel userModel = UserModel(
        id: user.uid,
        phoneNumber: user.phoneNumber!,
        username: username!,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set(userModel.toFirestore());
    }
  }
}

// class UserInformation {
//   final String uid;
//   final String? phoneNumber;

  // UserInformation({
  //   required this.uid,
  //   this.phoneNumber,
  // });
//}
