import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AuthProvider {
  late FirebaseAuth _firebaseAuth;

  AuthProvider() {
    _firebaseAuth = FirebaseAuth.instance;
  }

  User getUser() {
    return _firebaseAuth.currentUser!;
  }

  Future<bool> changePassword(
      String currentPassword, String newPassword, BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(email: user!.email!, password: currentPassword);
    String? errorMessage;
    try {
      await user.reauthenticateWithCredential(cred).then((value) {
        user.updatePassword(newPassword).then((_) {
          _firebaseAuth.signOut();

          Navigator.pushNamedAndRemoveUntil(context, "login", (route) => false);
        }).catchError((error) {
          print(error);
        });
      }).catchError((e) {
        if (e.code == 'user-not-found') {
          errorMessage = 'Ningun usuario encontrado con el email.';
        } else if (e.code == 'wrong-password') {
          print("wron pass");
          errorMessage = 'Contraseña incorrecta';
        } else if (e.code == 'too-many-requests') {
          errorMessage = 'Demasiados peticiones';
        }
      });
    } on FirebaseAuthException catch (e) {
      print("error");
      if (e.code == 'user-not-found') {
        errorMessage = 'Ningun usuario encontrado con el email.';
      } else if (e.code == 'wrong-password') {
        print("wron pass");
        errorMessage = 'Contraseña incorrecta';
      } else if (e.code == 'too-many-requests') {
        errorMessage = 'Demasiados peticiones';
      }
    } catch (error) {
      print(error);
    }
    if (errorMessage != null) {
      return Future.error(errorMessage!);
    }

    return true;
  }

  String? isSignedIn() {
    final currentUser = _firebaseAuth.currentUser;
    // print(currentUser);

    if (currentUser != null) {
      return currentUser.email;
    }

    return null;
  }

  Future<bool> login(String email, String password) async {
    String? errorMessage;

    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'user-not-found') {
        errorMessage = 'Ningun usuario encontrado con el email $email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Contraseña incorrecta';
      } else if (e.code == 'too-many-requests') {
        errorMessage = 'Demasiados peticiones';
      }
    } catch (error) {
      print(error);
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }

    return true;
  }

  Future<bool> register(String email, String password) async {
    String? errorMessage;

    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorMessage = 'La contraseña es muy débil.';
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'El email ya ha sido registrado anteriormente';
        print('The account already exists for that email.');
      }
    } catch (error) {
      print(error);
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }

    return true;
  }

  Future signOut() async {
    return Future.wait([_firebaseAuth.signOut()]);
  }
}
