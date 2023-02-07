import '../model/picture.dart';

abstract class DatabaseProcess{
  Future<Picture> getPicture();
}