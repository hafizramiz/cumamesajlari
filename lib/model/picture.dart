class Picture{
  Stream<List<String>> ? pictureStreamUrlList;
  String? error;
  Picture({ required this.pictureStreamUrlList});
  Picture.withError(String errorMessage) {
    error = errorMessage;
  }
}