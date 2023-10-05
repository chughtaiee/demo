import 'package:demo/ads/app_lifecycle_reactor.dart';
import 'package:demo/ads/app_open_ad_manager.dart';
import 'package:demo/my_home_page.dart';
import 'package:demo/provider/ad_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  AppLifecycleReactor appLifecycleReactor =
      AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
  appLifecycleReactor.listenToAppStateChanges();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static bool isInterstitialOn = false;
  static bool isAppOpenOn = false;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   print("state changed");
  //   if (state == AppLifecycleState.resumed) {
  //     appOpenAdManager.showAdIfAvailable();
  //     // The app has come to the foreground (opened or brought back from the background).
  //     // You can put code here to handle what happens when the app is in the foreground.
  //   } else if (state == AppLifecycleState.inactive ||
  //       state == AppLifecycleState.paused) {
  //     // The app is in the background or about to go into the background.
  //     // You can put code here to handle what happens when the app is in the background.
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AdProvider()),
      ],
      child: MaterialApp(
        title: 'App Open Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'App Open Demo Home Page'),
      ),
    );
  }
}
