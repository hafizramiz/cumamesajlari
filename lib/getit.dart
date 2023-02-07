import 'package:cumamesajlari/repositroy/picture_repository.dart';
import 'package:cumamesajlari/services/fake_data_process.dart';
import 'package:cumamesajlari/services/storage_process.dart';
import 'package:get_it/get_it.dart';

final getIt=GetIt.instance;
/// Bu fonksiyonu main icinde runAppden once cagiyiorum ki her bir siniftan bir nesne uretiyim.
/// Uygulama acilmadan bunu yapmam gereklidir.
void setUpGetIt(){
  getIt.registerSingleton<FakeDataProcess>(FakeDataProcess());
  getIt.registerSingleton<StorageProcess>(StorageProcess());
  getIt.registerSingleton<PictureRepository>(PictureRepository());
}