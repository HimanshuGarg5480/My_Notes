import 'package:flutter/material.dart';
import 'package:mynotes/services/auth/authservice.dart';

import '../constants/routes.dart';

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
        const Text(
            "we've sent you an email verrifaction. Please open it to verify your account."),
        const Text(
            "If you haven't received a verification email yet,press the button below"),
        TextButton(
          onPressed: () async {
            await AuthService.firebase().sendEmailVerification();
          },
          child: Text('Send Email Verification'),
        ),
        TextButton(
          onPressed: () async {
            await AuthService.firebase().logOut();
            Navigator.of(context)
                .pushNamedAndRemoveUntil(registerroute, (route) => false);
          },
          child: const Text('restart'),
        )
      ]),
    );
  }
}
