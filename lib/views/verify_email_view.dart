import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class verifyemailview extends StatefulWidget {
  const verifyemailview({Key? key}) : super(key: key);

  @override
  State<verifyemailview> createState() => _verifyemailviewState();
}

class _verifyemailviewState extends State<verifyemailview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify Email')),
      body: Column(children: [
        Text('please verify your email'),
        TextButton(
          onPressed: () async {
            final user = FirebaseAuth.instance.currentUser;
            await user?.sendEmailVerification();
          },
          child: Text('Send Email Verification'),
        )
      ]),
    );
  }
}
