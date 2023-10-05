import 'package:demo/ads/ad_helper.dart';
import 'package:demo/provider/ad_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class NativeTemplateAdManager {
  NativeAd? nativeAd;

  void loadAd(BuildContext context) {
    // setState(() {
    Provider.of<AdProvider>(context, listen: false).nativeTemplateLoaded(false);
    // });

    nativeAd = NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          // ignore: avoid_print
          print('$NativeAd loaded.');
          // setState(() {
          Provider.of<AdProvider>(context, listen: false)
              .nativeTemplateLoaded(true);

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
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
        mainBackgroundColor: const Color(0xfffffbed),
        callToActionTextStyle: NativeTemplateTextStyle(
            textColor: Colors.white,
            style: NativeTemplateFontStyle.monospace,
            size: 16.0),
        primaryTextStyle: NativeTemplateTextStyle(
            textColor: Colors.black,
            style: NativeTemplateFontStyle.bold,
            size: 16.0),
        secondaryTextStyle: NativeTemplateTextStyle(
            textColor: Colors.black,
            style: NativeTemplateFontStyle.italic,
            size: 16.0),
        tertiaryTextStyle: NativeTemplateTextStyle(
            textColor: Colors.black,
            style: NativeTemplateFontStyle.normal,
            size: 16.0),
      ),
    )..load();
  }
}
