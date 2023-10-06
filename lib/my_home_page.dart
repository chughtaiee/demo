import 'package:demo/ads/interstitial_ad_manager.dart';
import 'package:demo/ads/native_factory_ad_manager.dart';
import 'package:demo/ads/native_template_ad_manager.dart';
import 'package:demo/provider/ad_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

/// Example home page for an app open ad.
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  InterstitialAdManager interstitialAdManager = InterstitialAdManager();
  NativeTemplateAdManager nativeTemplateAdManager = NativeTemplateAdManager();
  NativeFactoryAdManager nativeFactoryAdManager = NativeFactoryAdManager();

  String? _versionString;
  // final double _adAspectRatioSmall = (91 / 355);
  final double _adAspectRatioMedium = (370 / 355);

  @override
  void initState() {
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    interstitialAdManager.showAd();
  }

  void _loadVersionString() {
    MobileAds.instance.getVersionString().then((value) {
      setState(() {
        _versionString = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.width *
                          _adAspectRatioMedium,
                      width: MediaQuery.of(context).size.width),
                  if (Provider.of<AdProvider>(context)
                          .nativeTemplateAdIsLoaded &&
                      nativeTemplateAdManager.nativeAd != null)
                    SizedBox(
                      height: MediaQuery.of(context).size.width *
                          _adAspectRatioMedium,
                      width: MediaQuery.of(context).size.width,
                      child: AdWidget(ad: nativeTemplateAdManager.nativeAd!),
                    ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  nativeTemplateAdManager.loadAd(context);
                  nativeFactoryAdManager.loadAd(context);
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.amber,
                  child: const Text("Refresh Ad"),
                ),
              ),
              if (Provider.of<AdProvider>(context).nativeFactoryAdIsLoaded &&
                  nativeFactoryAdManager.nativeAd != null)
                SizedBox(
                  height: 800,
                  width: MediaQuery.of(context).size.width,
                  child: AdWidget(ad: nativeFactoryAdManager.nativeAd!),
                ),
              if (_versionString != null) Text(_versionString!)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
