import 'dart:math';

import 'package:cumamesajlari/core/database_process.dart';
import 'package:cumamesajlari/model/picture.dart';

class FakeDataProcess implements DatabaseProcess {
  @override
  Future<Picture> getPicture() async {
    try {
      Picture _picture =
        Picture(pictureUrlList: [
          "https://i.cnnturk.com/i/cnnturk/75/740x416/5ff7e93fc8c37307f0d4ae9f.jpg",
          "https://i.cnnturk.com/i/cnnturk/75/740x416/5ff7e93fc8c37307f0d4ae9f.jpg",
        ]);
      return await _picture;
      /// Burada Storage'e gittim veriyi getirdim.Eger getiremezse Catch'e girer
    } catch (error) {
      /// Burada bir tane Picture nesnesi doner
      Picture _pictureError=Picture.withError("Hata meydana geldi");
      print(error);
      return _pictureError;
    }
  }
}
