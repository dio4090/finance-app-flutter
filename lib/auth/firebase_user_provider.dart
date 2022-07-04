import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class AppFirebaseFirebaseUser {
  AppFirebaseFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

AppFirebaseFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<AppFirebaseFirebaseUser> appFirebaseFirebaseUserStream() => FirebaseAuth
    .instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<AppFirebaseFirebaseUser>(
        (user) => currentUser = AppFirebaseFirebaseUser(user));
