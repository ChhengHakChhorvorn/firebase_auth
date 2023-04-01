import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/Views/ForgotPassword.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'Views/HomePage.dart';
import 'Views/SignupPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController txtEmail = TextEditingController();
    TextEditingController txtPassword = TextEditingController();
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
                        "Sign in",
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
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
                  Container(
                    width: double.infinity,
                    child: CupertinoButton(
                      child: Text("Sign in"),
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: txtEmail.text,
                                  password: txtPassword.text)
                              .then((value) => {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              HomePageScreen(),
                                        ))
                                  });
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                            Navigator.pop(context);
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                            Navigator.pop(context);
                          }
                        }
                      },
                      color: Color(0xffFE9C80),
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPasswordScreen(),
                                ));
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.grey),
                          ))
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: CupertinoButton(
                      child: Text("Login With Facebook"),
                      onPressed: () async {
                        final LoginResult result =
                            await FacebookAuth.instance.login();
                        if (result.status == LoginStatus.success) {
                          final AccessToken accessToken = result.accessToken!;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePageScreen(),
                            ),
                          );
                        } else {
                          print(result.status);
                          print(result.message);
                        }
                      },
                      color: Color(0xffFE9C80),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",
                          style: TextStyle(color: Colors.grey)),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpScreen(),
                                ));
                          },
                          child: Text("Sign up",
                              style: TextStyle(color: Colors.black)))
                    ],
                  )
                ]),
          ),
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://r1.ilikewallpaper.net/iphone-8-wallpapers/download/34402/Color-Blur-Background--iphone-8-wallpaper-ilikewallpaper_com_200.jpg"),
                    fit: BoxFit.cover)),
          )),
    );
  }
}
