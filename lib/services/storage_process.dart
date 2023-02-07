import 'dart:async';

import 'package:cumamesajlari/core/database_process.dart';
import 'package:cumamesajlari/model/picture.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageProcess implements DatabaseProcess {
  @override
  Future<Picture> getPicture() async {
    final storage = FirebaseStorage.instance;
    final _storageRef = storage.ref("pictures");

    final ListResult listResult = await _storageRef.listAll();
    List<String> urlItemList = [];

    for (var item in listResult.items) {
      var urlItem = await item.getDownloadURL();
      urlItemList.add(urlItem);
    }

    Picture picture = Picture(pictureUrlList: urlItemList);
    return await picture;
  }
  //
  // getPictureWithStream() async {
  //   final storage = FirebaseStorage.instance;
  //   final _storageRef = storage.ref("pictures");
  //   Stream<ListResult> myStream = listAllPaginated(_storageRef);
  //
  //   Stream<List<Reference>> newStream = myStream.map((event) {
  //     return event.items;
  //   });
  //   List<String> urlItemList = [];
  //
  //   // for (var item in event.items) {
  //   //   String urlItem = await item.getDownloadURL();
  //   //   print("url: $urlItem");
  //   //   urlItemList.add(urlItem);
  //   // }
  //   // Picture picture = Picture(pictureUrlList: urlItemList);
  //   // return picture;
  //   newStream.map((event){
  //
  //   });
  // }
  //
  // Stream<ListResult> listAllPaginated(Reference storageRef) async* {
  //   String? pageToken;
  //   do {
  //     final listResult = await storageRef.list(ListOptions(
  //       maxResults: 100,
  //       pageToken: pageToken,
  //     ));
  //     yield listResult;
  //     pageToken = listResult.nextPageToken;
  //   } while (pageToken != null);
  // }
}
