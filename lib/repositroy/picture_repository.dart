import 'package:cumamesajlari/core/database_process.dart';
import 'package:cumamesajlari/model/picture.dart';
import 'package:cumamesajlari/services/fake_data_process.dart';
import 'package:cumamesajlari/services/storage_process.dart';
import '../getit.dart';

enum AppMode{DEBUG, RELEASE}
AppMode appMode=AppMode.RELEASE;
class PictureRepository implements DatabaseProcess{
  var fakeDataProcess = getIt<FakeDataProcess>();
  var storageProcess=getIt<StorageProcess>();
  @override
  Future<Picture> getPicture() async{
    if(appMode==AppMode.DEBUG){
      Picture _picture= await fakeDataProcess.getPicture();
      return _picture;
    }else{
      Picture _picture= await storageProcess.getPicture();
      return _picture;
    }
  }
}