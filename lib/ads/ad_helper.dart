import 'dart:io';

class AdHelper {
  static String get nativeAdUnitId {
    return Platform.isAndroid
        ? 'ca-app-pub-3940256099942544/2247696110'
        : Platform.isIOS
            ? 'ca-app-pub-3940256099942544/3986624511'
            : throw UnsupportedError("Unsupported platform");
  }

  static String get appOpenAdUnitId {
    return Platform.isAndroid
        ? 'ca-app-pub-3940256099942544/3419835294'
        : Platform.isIOS
            ? 'ca-app-pub-3940256099942544/5662855259'
            : throw UnsupportedError("Unsupported platform");
  }

  static String get interstitialAdUnitId {
    return Platform.isAndroid
        ? 'ca-app-pub-3940256099942544/1033173712'
        : Platform.isIOS
            ? 'ca-app-pub-3940256099942544/4411468910'
            : throw UnsupportedError("Unsupported platform");
  }
}
