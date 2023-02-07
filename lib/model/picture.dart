class Picture{
   List<String>? pictureUrlList;
   String? error;
  Picture({ required this.pictureUrlList});
  Picture.withError(String errorMessage) {
    error = errorMessage;
  }
}