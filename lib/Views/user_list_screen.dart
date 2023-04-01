import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/Views/add_user_page.dart';
import 'package:flutter/material.dart';

import '../model/user_model.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: StreamBuilder<List<User>>(stream: readUsers() ,builder: (context, snapshot) {
        if(snapshot.hasData){
          final users = snapshot.data!;
          return ListView(children: users.map((e) => ListTile(
            leading: ClipOval(child: Text(e.userId.toString(),),),
            title: Text(e.userName),
            subtitle: Text(e.email),
          )).toList(),);
        }else if(snapshot.hasError)
          {
            print(snapshot.error);
            return Center(child: Text('Something went wrong'),);
          }else{
          return Center(child: CircularProgressIndicator(),);
        }
      },),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddUserScreen(),
            ),
          );
        },
      ),
    );
  }

  Stream<List<User>> readUsers() =>
      FirebaseFirestore.instance.collection('user').snapshots().map(
            (snapshot) => snapshot.docs
                .map(
                  (doc) => User.fromJson(
                    doc.data(),
                  ),
                )
                .toList(),
          );
}
