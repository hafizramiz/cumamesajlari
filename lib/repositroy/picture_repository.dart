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
  Picture getPicture() {
    if(appMode==AppMode.DEBUG){
      Picture _picture=  fakeDataProcess.getPicture();
      return _picture;
    }else{
      Picture _picture=  storageProcess.getPicture();
      return _picture;
    }
  }
}