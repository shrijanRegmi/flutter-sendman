import 'package:firebase_auth/firebase_auth.dart';
import 'package:send_man/models/app_user.dart';
import 'package:send_man/services/database/app_user_provider.dart';

class AuthProvider {
  final _auth = FirebaseAuth.instance;

  // sign in anynomously
  Future<User?> signInAnynomously() async {
    try {
      final _result = await _auth.signInAnonymously();

      await AppUserProvider().sendUserToFirestore(_result.user?.uid ?? '');

      print("Success: Signing in Anynomously");
      return _result.user;
    } catch (e) {
      print(e);
      print("Error!!!: Signing in Anynomously");
    }
  }

  // get app user from firebase
  AppUser? _appUserFromFirebase(User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  // stream of app user
  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(_appUserFromFirebase);
  }
}
