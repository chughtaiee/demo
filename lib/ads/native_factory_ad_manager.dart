import 'package:demo/ads/ad_helper.dart';
import 'package:demo/provider/ad_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class NativeFactoryAdManager {
  NativeAd? nativeAd;

  /// Loads a native ad.
  void loadAd(BuildContext context) {
    // setState(() {
    Provider.of<AdProvider>(context, listen: false).nativeFactoryLoaded(false);
    // });

    nativeAd = NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      factoryId: 'adFactoryExample',
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          // ignore: avoid_print
          print('$NativeAd loaded.');
          // setState(() {
          Provider.of<AdProvider>(context, listen: false)
              .nativeFactoryLoaded(true);
          // });
        },
        onAdFailedToLoad: (ad, error) {
          // ignore: avoid_print
          print('$NativeAd failedToLoad: $error');
          ad.dispose();
        },
        onAdClicked: (ad) {},
        onAdImpression: (ad) {},
        onAdClosed: (ad) {},
        onAdOpened: (ad) {},
        onAdWillDismissScreen: (ad) {},
        onPaidEvent: (ad, valueMicros, precision, currencyCode) {},
      ),
      request: const AdRequest(),
    )..load();
  }
}
