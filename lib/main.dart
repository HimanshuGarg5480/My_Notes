import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/register_view.dart';
import 'package:mynotes/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(home: homepage(), routes: {
      'login': (context) => const login_view(),
      'register': (context) => const register_view()
    }),
  );
}

class homepage extends StatelessWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            // return login_view();
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                print('email verified');
              } else {
                return const verifyemailview();
              }
            } else {
              return const login_view();
            }
            return const notesview();
          // if (user?.emailVerified ?? false) {
          //   print('email verified');
          //   return const Text('done');
          // } else {
            

          // }
          // return const login_view();

          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
enum MenuAction{logout}
class notesview extends StatefulWidget {
  const notesview({Key? key}) : super(key: key);

  @override
  State<notesview> createState() => _notesviewState();
}

class _notesviewState extends State<notesview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main UI'),
      ),
      body: Text('done'),
    );
  }
}
