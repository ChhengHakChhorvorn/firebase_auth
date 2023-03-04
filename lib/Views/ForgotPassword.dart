import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController txtEmail = TextEditingController();
    return Scaffold(
      body: SlidingUpPanel(
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
                        "Forgot Password?",
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Text("Please Enter Your Email to recover your account"),
                  TextField(
                    controller: txtEmail,
                    decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: CupertinoButton(
                      child: Text("Reset Password"),
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                        try {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: txtEmail.text);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyHomePage(),
                              ));
                        } on FirebaseAuthException catch (e) {
                          print(e);
                        }
                      },
                      color: Color(0xffFE9C80),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(),
                            ));
                      },
                      child: Text('Go Back!'))
                ]),
          ),
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://img.rawpixel.com/private/static/images/website/2022-05/v904-nunny-016_2.jpg?w=800&dpr=1&fit=default&crop=default&q=65&vib=3&con=3&usm=15&bg=F4F4F3&ixlib=js-2.2.1&s=d04dc64ebef3b6c3ad40a5687bbe31dc"),
                    fit: BoxFit.cover)),
          )),
    );
  }
}
