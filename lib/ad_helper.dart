import 'dart:io';

class AdHelper{

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6229914235416908/6653390291';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-6229914235416908/3177179715';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

}