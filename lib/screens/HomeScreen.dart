import 'package:flutter/material.dart';
import 'dart:io';
import 'package:task2np/models/AudioModel.dart';
import 'package:provider/provider.dart';
import 'package:task2np/models/PermissionModel.dart';

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
    final imageModels = Provider.of<AppFunctions>(context).imageModels;
    return Scaffold(
        appBar: AppBar(
          title: Text("Second Task"),
          backgroundColor: Colors.green[900],
          centerTitle: true,
        ),
        body: imageModels.length == list.length
            ? Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Image(
                                  image: NetworkImage(list[index].imageUrl),
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              )
            : Center(child: CircularProgressIndicator()));
  }
}
