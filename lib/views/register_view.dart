import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/firebase_options.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';

class register_view extends StatefulWidget {
  const register_view({Key? key}) : super(key: key);

  @override
  State<register_view> createState() => _register_viewState();
}

class _register_viewState extends State<register_view> {
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
        title: Text('Register'),
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
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email, password: password);
                final user = FirebaseAuth.instance.currentUser;
                user?.sendEmailVerification();
                Navigator.of(context).pushNamed(verifyemailviewroute);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  showerrordialog(
                    context,
                    'Weak Password',
                  );
                } else if (e.code == 'invalid-email') {
                  showerrordialog(
                    context,
                    'Invalid Email',
                  );
                } else if (e.code == 'email-already-in-use') {
                  showerrordialog(
                    context,
                    'Email Already In Use',
                  );
                } else {
                  showerrordialog(
                    context,
                    'Error: ${e.code}',
                  );
                }
              }
            },
            child: Text('register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginroute, (route) => false);
            },
            child: Text("Already registered? Login here!"),
          )
        ],
      ),
    );
  }
}
