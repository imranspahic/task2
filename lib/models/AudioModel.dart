import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class AudioModel {
  int id;
  String name;
  String audioUrl;
  File file;
  AudioModel({@required this.id, @required this.name, this.file});
}

class ImageModel {
  int id;
  String name;
  String imageUrl;
  ImageModel({@required this.id, @required this.name, this.imageUrl});
}

class AppFunctions with ChangeNotifier {
  List<AudioModel> _audioModels = [
    AudioModel(
      id: 1,
      name: "1.mp3",
    ),
    AudioModel(
      id: 2,
      name: "2.mp3",
    ),
    AudioModel(
      id: 3,
      name: "3.mp3",
    ),
    AudioModel(
      id: 4,
      name: "4.mp3",
    ),
    AudioModel(
      id: 5,
      name: "5.mp3",
    ),
    AudioModel(
      id: 6,
      name: "6.mp3",
    ),
    AudioModel(
      id: 7,
      name: "7.mp3",
    ),
    AudioModel(
      id: 8,
      name: "8.mp3",
    ),
    AudioModel(
      id: 9,
      name: "9.mp3",
    ),
    AudioModel(
      id: 10,
      name: "10.mp3",
    )
  ];

  List<ImageModel> _imageModels = [
    ImageModel(id: 1, name: "slika_1.jpg"),
    ImageModel(id: 2, name: "slika_2.png"),
  ];

  List<ImageModel> updatedImageModels = [];

  List<AudioModel> audioFiles = [];
  List<File> imageFiles = [];

  void insertInFirestore(int id, String name, dynamic model, bool audio) async {
    final storageRef = FirebaseStorage.instance.ref().child(name);
    final url = await storageRef.getDownloadURL();

    if (audio == false) {
      FirebaseFirestore.instance
          .collection("Files")
          .doc("AllFiles")
          .collection(audio == false ? "ImageFiles" : "AudioFiles")
          .doc(name)
          .set({"id": id, "Name": name, "url": url});
    }

    await saveDocFromFirestore(name, url, audio, id);
    if (audio == true) {
      checkForUpdate(audio, name, url, id);
    }

    print(url);
  }

  Future<void> checkForUpdate(
      bool audio, String name, String url, int id) async {
    if (audio == false) {
      updatedImageModels.add(ImageModel(id: id, name: name, imageUrl: url));
    }
  }

  Widget retWdgt() {
    ListTile tile;
    audioFiles.forEach((element) {
      if (element.id <= 5) {
        tile = ListTile(
          leading: Icon(Icons.play_arrow),
          onTap: () {},
        );
      } else if (element.id >= 6 && element.id <= 8) {
        tile = ListTile(
          title: Text("Press to Play"),
          onTap: () {},
        );
      }
    });
    return tile;
  }

  connectTiles() {
    final List<ListTile> audioList = [];
    audioFiles.forEach((element) {
      var tile;
      if (element.id <= 5) {
        tile = ListTile(
          leading: Icon(Icons.play_arrow),
          onTap: () {},
        );
        audioList.add(tile);
      } else if (element.id >= 6 && element.id >= 8) {
        tile = ListTile(
          title: Text("Press to Play"),
          onTap: () {},
        );
        audioList.add(tile);
      }
    });
    return audioList;
  }

  Future saveDocFromFirestore(
      String name, String documentURL, bool check, int id) async {
    final url = await http.get(documentURL);
    String pathName = check == true ? "/audios" : "/images";
    final path = await getExternalStorageDirectory();
    final dir = path.path + pathName;
    final Directory newDir = Directory(dir);
    if (!newDir.existsSync()) {
      newDir.create(recursive: true);
    }
    final file = dir + "$name";
    final finFile = File(file);
    print(finFile);
    finFile.writeAsBytes(url.bodyBytes);

    if (check == false) {
      if (!imageFiles.contains(finFile)) {
        imageFiles.add(finFile);
        notifyListeners();
        print(imageFiles);
      }
    } else {
      if (!audioFiles.contains(finFile)) {
        notifyListeners();
        audioFiles.add(AudioModel(id: id, name: name, file: finFile));
      }
    }
  }

  void processDocuments(bool checkForType) {
    if (checkForType == true) {
      _audioModels.forEach((element) {
        insertInFirestore(element.id, element.name, element, checkForType);
      });
    } else {
      _imageModels.forEach((element) {
        insertInFirestore(element.id, element.name, element, checkForType);
      });
    }
  }
}
