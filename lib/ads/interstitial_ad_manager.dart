import 'package:demo/ads/ad_helper.dart';
import 'package:demo/main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Loads an interstitial ad.

class InterstitialAdManager {
  InterstitialAd? _interstitialAd;

  void loadAd() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (InterstitialAd ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
              // Called when the ad showed the full screen content.
              onAdShowedFullScreenContent: (ad) {},
              // Called when an impression occurs on the ad.
              onAdImpression: (ad) {},
              // Called when the ad failed to show full screen content.
              onAdFailedToShowFullScreenContent: (ad, err) {
                ad.dispose();
                _interstitialAd = null;
                MyApp.isInterstitialOn = false;
                loadAd();
              },
              // Called when the ad dismissed full screen content.
              onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
                MyApp.isInterstitialOn = false;
                _interstitialAd = null;
                loadAd();
              },
              // Called when a click is recorded for an ad.
              onAdClicked: (ad) {},
            );

            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            // ignore: avoid_print
            print('InterstitialAd failed to load: $error');
          },
        ));
  }

  void showAd() {
    MyApp.isInterstitialOn || MyApp.isAppOpenOn
        ? print("Already An Add is opened")
        : _interstitialAd == null
            ? loadAd()
            : {_interstitialAd?.show(), MyApp.isInterstitialOn = true};
  }
}
