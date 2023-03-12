import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {

  CollectionReference _collectionReference = FirebaseFirestore.instance.collection('user');

  getUerList() async {
    QuerySnapshot querySnapshot = await _collectionReference.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return allData;
  }

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
        body: FutureBuilder(
          future: getUerList(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return snapshot.hasError
                ? Center(
                    child: Text('Database has Error'),
                  )
                : snapshot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : snapshot.hasData
                        ? ListView.builder(
              itemCount: snapshot.data.length,
              shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                child: ListTile(
                                  title: Text(snapshot.data![index]['userName']),
                                ),
                              );
                            },
                          )
                        : SizedBox.shrink();
          },
        ));
  }
}
