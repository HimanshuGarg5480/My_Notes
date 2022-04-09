import 'package:firebase_auth/firebase_auth.dart' show User;

class AuthUser {
  final bool isemailverified;

  AuthUser(this.isemailverified);
  factory AuthUser.fromfirebase(User user) => AuthUser(user.emailVerified);
}
