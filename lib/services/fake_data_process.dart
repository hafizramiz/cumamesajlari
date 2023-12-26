
import 'package:cumamesajlari/core/database_process.dart';
import 'package:cumamesajlari/model/picture.dart';


/// Burada fake stream olusturcam ve dondurcem
Stream<List<String>>? createFakeStream()async*{
  List<String>? fakeStreamUrlList=["https://i2.milimaj.com/i/milliyet/75/0x0/61a74dfd86b24a0f203e87b1.jpg"];
  for (int i=0; i<=10;i++){
    await Future.delayed(Duration(seconds: 1));
    fakeStreamUrlList.add("https://i2.milimaj.com/i/milliyet/75/0x0/61a74e0f86b24a0f203e87b5.jpg");
    yield fakeStreamUrlList;
  }
}

class FakeDataProcess implements DatabaseProcess {
  @override
 Picture getPicture() {
    try {
      Picture _picture =Picture(pictureStreamUrlList: createFakeStream());
      return  _picture;
      /// Burada Storage'e gittim veriyi getirdim.Eger getiremezse Catch'e girer
    } catch (error) {
      /// Burada bir tane Picture nesnesi doner
      Picture _pictureError=Picture.withError("Hata meydana geldi");
      print(error);
      return _pictureError;
    }
  }

}
