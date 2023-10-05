import 'package:flutter/material.dart';

class AdProvider extends ChangeNotifier {
  bool nativeTemplateAdIsLoaded = false;
  nativeTemplateLoaded(bool adLoaded) {
    nativeTemplateAdIsLoaded = adLoaded;
    notifyListeners();
  }

  bool nativeFactoryAdIsLoaded = false;
  nativeFactoryLoaded(bool adLoaded) {
    nativeFactoryAdIsLoaded = adLoaded;
    notifyListeners();
  }
}
