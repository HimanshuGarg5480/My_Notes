import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';

class login_view extends StatefulWidget {
  const login_view({Key? key}) : super(key: key);

  @override
  State<login_view> createState() => _login_viewState();
}

class _login_viewState extends State<login_view> {
  late TextEditingController _email;
  late TextEditingController _password;
  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            autocorrect: false,
            enableSuggestions: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: 'enter your email'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            autocorrect: false,
            enableSuggestions: false,
            decoration: InputDecoration(hintText: 'enter your password'),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                final UserCredential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: email, password: password);
                print(UserCredential);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'wrong-password') {
                  print('Wrong Password');
                } else if (e.code == 'user-not-found') {
                  print('User Not Found');
                } else {
                  print('Something Bad Happened');
                }
              } catch (e) {
                print(e);
              }
            },
            child: Text('login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('register', (route) => false);
            },
            child: Text('Not Registered Yet?Register here!'),
          ),
        ],
      ),
    );
  }
}
