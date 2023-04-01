import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/Views/product_list_screen.dart';
import 'package:firebase_demo/Views/user_list_screen.dart';
import 'package:firebase_demo/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'add_user_page.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  AccessToken? _accessToken;
  bool _checking = true;
  dynamic user;

  @override
  void initState() {
    super.initState();
    Future<void> _checkIfIsLogged() async {
      final accessToken = await FacebookAuth.instance.accessToken;
      setState(() {
        _checking = false;
      });
      if (accessToken != null) {
        final userData = await FacebookAuth.instance.getUserData();
        _accessToken = accessToken;
        setState(() {
          user = userData;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      user = FirebaseAuth.instance.currentUser;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(
                child: Text('User Database'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserListScreen(),
                    ),
                  );
                },
                color: Colors.redAccent,
              ),
              CupertinoButton(
                child: Text('Product List'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductListScreen(),
                    ),
                  );
                },
                color: Colors.deepPurpleAccent,
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
                  child: Text('Logout'),)
            ],
          ),
        ),
      )),
    );
  }
}
