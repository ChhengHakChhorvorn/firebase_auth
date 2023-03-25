import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: txtName,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Name'),
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: txtEmail,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Email'),
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: txtPassword,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Password'),
              ),
            ),
            SizedBox(height: 20,),
            CupertinoButton(
              child: Text("Add"),
              color: Colors.blue,
              onPressed: () => addUser(),
            )
          ],
        ),
      ),
    );
  }

  addUser() async {
    final db = FirebaseFirestore.instance.collection('user');
    final json = {
      'userId' : DateTime.now().millisecond.toString(),
      'userName' : txtName.text,
      'password': txtPassword.text,
      'email' : txtEmail.text
    };
    //add Data
    //db.add(json);

    //Update Data
    db.doc('IfbS3ibrEexnXx874BA8').update({
      'userName': 'David Long'
    });

    //Delete data
    db.doc('IfbS3ibrEexnXx874BA8').delete();
  }
}
