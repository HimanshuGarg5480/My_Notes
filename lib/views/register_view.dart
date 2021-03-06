import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exception.dart';
import 'package:mynotes/services/auth/authservice.dart';
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
                await AuthService.firebase()
                    .createUser(email: email, password: password);
                AuthService.firebase().sendEmailVerification();
                Navigator.of(context).pushNamed(verifyemailviewroute);
              } on WeakPasswordAuthException {
                showerrordialog(
                  context,
                  'Weak Password',
                );
              } on InvalidEmailAuthException {
                showerrordialog(
                  context,
                  'Invalid Email',
                );
              } on EmailAlreadyInUseAuthException {
                showerrordialog(
                  context,
                  'Email Already In Use',
                );
              } on GenericAuthException {
                showerrordialog(
                  context,
                  'Failed to register',
                );
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
