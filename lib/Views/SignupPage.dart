import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../main.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController txtEmail = TextEditingController();
    TextEditingController txtPassword = TextEditingController();
    TextEditingController txtName = TextEditingController();
    return Scaffold(
      body: SlidingUpPanel(
        defaultPanelState: PanelState.OPEN,
        borderRadius: BorderRadius.circular(20),
        panel: Container(
          padding: EdgeInsets.all(20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      "Sign up",
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: txtEmail,
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: txtPassword,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: txtName,
                  decoration: InputDecoration(
                    hintText: "Profile Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: CupertinoButton(
                    child: Text("Sign up"),
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: txtEmail.text,
                          password: txtPassword.text,
                        );
                        FirebaseAuth.instance
                            .authStateChanges()
                            .listen((User? user) async {
                          if (user != null) {
                            await user
                                .updateDisplayName(txtName.text)
                                .then((value) => {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MyHomePage(),
                                          ))
                                    });
                          }
                        });
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    color: Color(0xffA9D5C1),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?",
                        style: TextStyle(color: Colors.grey)),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyHomePage(),
                              ));
                        },
                        child: Text("Sign in",
                            style: TextStyle(color: Colors.black)))
                  ],
                )
              ]),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://marketplace.canva.com/EAD2962NKnQ/2/0/1600w/canva-rainbow-gradient-pink-and-purple-zoom-virtual-background-_Tcjok-d9b4.jpg"),
                  fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
