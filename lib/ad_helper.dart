import 'dart:io';

class AdHelper{
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6229914235416908/7934310236';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-6229914235416908/7934310236';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}