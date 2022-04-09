import 'dart:developer' as devtools show log;

import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/authservice.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/notes_view.dart';
import 'package:mynotes/views/register_view.dart';
import 'package:mynotes/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(home: homepage(), routes: {
      loginroute: (context) => const login_view(),
      registerroute: (context) => const register_view(),
      notesroute: (context) => const notesview(),
      verifyemailviewroute: (context) => const verifyemailview(),
    }),
  );
}

class homepage extends StatelessWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            // return login_view();
            final user = AuthService.firebase().currentuser;
            if (user != null) {
              if (user.isemailverified) {
                devtools.log('email verified');
              } else {
                return const verifyemailview();
              }
            } else {
              return const login_view();
            }
            return const notesview();
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

Future<bool> showlogoutdilog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('log out'),
          )
        ],
      );
    },
  ).then((value) => value ?? false);
}
