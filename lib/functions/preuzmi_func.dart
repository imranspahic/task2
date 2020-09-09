import 'dart:io';
import 'package:path_provider/path_provider.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';

class PreuzmiFunc {
  Future<bool> provjeriFajlove() async {
    Directory dir = await path.getExternalStorageDirectory();
    String downloadPath = '${dir.path}/audio';
    print(dir.path);
    Directory downloadDir = Directory(downloadPath);
    if (downloadDir.existsSync()) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> preuzmi() async {
    StorageReference storageReference = FirebaseStorage.instance.ref();
    final Directory dir = await path.getExternalStorageDirectory();
    final String downloadPath = '${dir.path}/audio';

    try {
      for (int i = 1; i <= 10; i++) {
        final File fajl = File('$downloadPath/$i.mp3');

        if (fajl.existsSync()) {
          continue;
        } else {
          await fajl.create(recursive: true);

          final StorageFileDownloadTask downloadTask =
              storageReference.child('$i.mp3').writeToFile(fajl);
        }
      }

      return true;
    } catch (error) {
      return false;
    }
  }
}
