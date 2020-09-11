import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:io';
import 'package:task2np/models/AudioModel.dart';
import 'package:provider/provider.dart';
import 'package:task2np/models/PermissionModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool check;
  bool isinit;
  List<ImageModel> list;

  @override
  void initState() {
    super.initState();
    isinit = true;
    PermissionModel().requestPermission().then((value) => PermissionModel()
        .checkPermissionStatus()
        .then((value) => check = value));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (isinit == true) {
      final prov = Provider.of<AppFunctions>(context);
      prov.processDocuments(false);
      list = prov.updatedImageModels;
      isinit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageModels = Provider.of<AppFunctions>(context);
    final instace = FirebaseFirestore.instance
        .collection("Files/AllFiles/ImageFiles")
        .orderBy("id");

    return Scaffold(
        appBar: AppBar(
          title: Text("Second Task"),
          backgroundColor: Colors.green[900],
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: instace.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              print(snapshot.data.documents.length);
              final documents = snapshot.data.docs;
              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              leading: CircleAvatar(
                            child: Image(
                              image: NetworkImage(
                                documents[index].get("url"),
                              ),
                            ),
                          ));
                        }),
                  )
                ],
              );
            }
          },
        ));
  }
}
