import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';

import 'screens/first_menu.dart';

const String testDevice = 'MobileId';

const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  testDevices: testDevice != null ? <String>[testDevice] : null,
  nonPersonalizedAds: false,
  keywords: <String>[
    'Jeux',
    'Mario',
    'Vêtements',
    'Vêtement',
    'Marque',
    'Mode',
    'Acessoires',
    'Mobile',
    'Montres',
    'Chaussures',
    'Bagues',
    'Bracelets',
    'Bijoux',
  ],
);

BannerAd _bannerAd;

BannerAd createBannerAd() {
  return BannerAd(
      adUnitId: 'ca-app-pub-2326522849891159/7532525720',
      //Change BannerAd adUnitId with Admob ID
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd $event");
      });
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: 'ca-app-pub-2326522849891159~6185700758');
    //Change appId With Admob Id
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bloc Note',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: FirstMenu(),
      builder: (BuildContext context, Widget child) {
        double screenHeight = MediaQuery.of(context).size.height;
        _bannerAd = createBannerAd()
          ..load()
          ..show(
            anchorType: AnchorType.bottom,
          );
        return Padding(
          child: child,
          padding: EdgeInsets.only(
            bottom: Ads.getMargin(screenHeight),
          ),
        );
      },
    );
  }
}

class Ads {
  static double getMargin(double height){
    double margin;
    if(height <= 400){
      margin = 32;
    } else if(height >= 400 && height < 720){
      margin = 50;
    } else if(height >= 720){
      margin = 90;
    }
    return margin;
  }
}