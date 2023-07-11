import 'dart:async';
import 'dart:math';

import 'package:cumamesajlari/core/database_process.dart';
import 'package:cumamesajlari/model/picture.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageProcess implements DatabaseProcess {
  @override
  Picture getPicture() {
    Stream<List<String>> pictureStreamUrlList = listAllPaginated();
    Picture picture = Picture(pictureStreamUrlList: pictureStreamUrlList);
    return picture;
  }

  Stream<List<String>> listAllPaginated() async* {
    final Reference storageRef = FirebaseStorage.instance.ref("pictures");

    String? pageToken;
    do {
      final listResult = await storageRef.list(ListOptions(
        maxResults: 100,
        pageToken: pageToken,
      ));
      final List<String> urlListesi = [];
      for (var item in listResult.items) {
        String urlItem = await item.getDownloadURL();
        urlListesi.add(urlItem);
        print("Gelen liste elemani sayisi:${urlListesi.length}");
      }
      yield urlListesi;
      pageToken = listResult.nextPageToken;
    } while (pageToken != null);
  }
}
