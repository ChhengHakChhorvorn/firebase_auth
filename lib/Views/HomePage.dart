import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/main.dart';
import 'package:flutter/material.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text("WELCOME BACK!"),
            ),
            Center(
              child: Text(user.displayName ?? "No Name"),
            ),
            TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut().then((value) => {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(),
                            ))
                      });
                },
                child: Text('Logout'))
          ],
        ),
      )),
    );
  }
}
