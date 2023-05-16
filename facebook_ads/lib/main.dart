// import 'package:facebook_audience_network/facebook_audience_network.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'controller/fb_ads_controller.dart';
// import 'view/splash.dart';

// late FbAdsController fbAdsController;
// void main() {
//   fbAdsController = Get.put(FbAdsController());

//   WidgetsFlutterBinding.ensureInitialized();

//   //test ads device
//   // var devices = ["16030F86706F94B8A854A3576D1CF9A3"];
//   // RequestConfiguration requestConfiguration =
//   //     RequestConfiguration(testDeviceIds: devices);
//   // MobileAds.instance.updateRequestConfiguration(requestConfiguration);
// AdSettings.addTestDevice("602e6d14-bf82-4ce1-8396-19d1e1f79376");
//   FacebookAudienceNetwork.init(
//       testingId: "d9fd1c39-2145-425a-8ea3-68cb2e50284e", //optional
//       // testingId: "37b1da9d-b48c-4103-a393-2e095e734bd6", //optional
//       iOSAdvertiserTrackingEnabled: true //default false
//       );

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: LoadingSplash(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';

void main() => runApp(AdExampleApp());

class AdExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FB Audience Network Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
          buttonColor: Colors.blue,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "FB Audience Network Example",
          ),
        ),
        body: AdsPage(),
      ),
    );
  }
}

class AdsPage extends StatefulWidget {
  @override
  AdsPageState createState() => AdsPageState();
}

class AdsPageState extends State<AdsPage> {
  bool _isInterstitialAdLoaded = false;
  bool _isRewardedAdLoaded = false;

  /// All widget ads are stored in this variable. When a button is pressed, its
  /// respective ad widget is set to this variable and the view is rebuilt using
  /// setState().
  Widget _currentAd = SizedBox(
    width: 0.0,
    height: 0.0,
  );

  @override
  void initState() {
    super.initState();

    // FacebookAudienceNetwork.init();
    FacebookAudienceNetwork.init(
      testingId: "9b5cd373-9437-4d64-8bc1-a3c3b4477805",
      // testingId: "a77955ee-3304-4635-be65-81029b0f5201",
      // iOSAdvertiserTrackingEnabled: true,
    );

    _loadInterstitialAd();
    _loadRewardedVideoAd();
  }

  void _loadInterstitialAd() {
    FacebookInterstitialAd.loadInterstitialAd(
      // placementId: "YOUR_PLACEMENT_ID",
      placementId:
          "CAROUSEL_IMG_SQUARE_APP_INSTALL#265036219221143_265036855887746",
      listener: (result, value) {
        print(">>>>>>> Interstitial Ad: $result --> $value");
        if (result == InterstitialAdResult.LOADED)
          _isInterstitialAdLoaded = true;

        /// Once an Interstitial Ad has been dismissed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {
          _isInterstitialAdLoaded = false;
          _loadInterstitialAd();
          return;
        }
      },
    );
  }

  void _loadRewardedVideoAd() {
    FacebookRewardedVideoAd.loadRewardedVideoAd(
      placementId: "VID_HD_9_16_39S_LINK#265036219221143_265037532554345",
      listener: (result, value) {
        print("<<<<<<<<Rewarded Ad: $result --> $value");
        if (result == RewardedVideoAdResult.LOADED) _isRewardedAdLoaded = true;
        // if (result == RewardedVideoAdResult.VIDEO_COMPLETE)

        /// Once a Rewarded Ad has been closed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == RewardedVideoAdResult.VIDEO_CLOSED &&
            (value == true || value["invalidated"] == true)) {
          _isRewardedAdLoaded = false;
          _loadRewardedVideoAd();
          return;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: Align(
            alignment: Alignment(0, -1.0),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: _getAllButtons(),
            ),
          ),
          fit: FlexFit.tight,
          flex: 2,
        ),
        // Column(children: <Widget>[
        //   _nativeAd(),
        //   // _nativeBannerAd(),
        //   _nativeAd(),
        // ],),
        Flexible(
          child: Align(
            alignment: Alignment(0, 1.0),
            child: _currentAd,
          ),
          fit: FlexFit.tight,
          flex: 3,
        )
      ],
    );
  }

  Widget _getAllButtons() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 3,
      children: <Widget>[
        _getRaisedButton(title: "Banner Ad", onPressed: _showBannerAd),
        _getRaisedButton(title: "Native Ad", onPressed: _showNativeAd),
        _getRaisedButton(
            title: "Native Banner Ad", onPressed: _showNativeBannerAd),
        _getRaisedButton(
            title: "Intestitial Ad", onPressed: _showInterstitialAd),
        _getRaisedButton(title: "Rewarded Ad", onPressed: _showRewardedAd),
      ],
    );
  }

  Widget _getRaisedButton({required String title, void Function()? onPressed}) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  _showInterstitialAd() {
    if (_isInterstitialAdLoaded == true)
      FacebookInterstitialAd.showInterstitialAd();
    else {
      print("Interstial Ad not yet loaded!");
      // _loadInterstitialAd();
      // _loadRewardedVideoAd();
    }
  }

  _showRewardedAd() {
    if (_isRewardedAdLoaded == true)
      FacebookRewardedVideoAd.showRewardedVideoAd();
    else {
      print("Rewarded Ad not yet loaded!");
      // _loadInterstitialAd();
      // _loadRewardedVideoAd();
    }
  }

  _showBannerAd() {
    setState(() {
      _currentAd = FacebookBannerAd(
        // placementId: "YOUR_PLACEMENT_ID",
        placementId: "IMG_16_9_LINK#265036219221143_265036602554438", //testid
        bannerSize: BannerSize.STANDARD,
        listener: (result, value) {
          print("Banner Ad: $result -->  $value");
        },
      );
    });
  }

  _showNativeBannerAd() {
    setState(() {
      _currentAd = _nativeBannerAd();
    });
  }

  Widget _nativeBannerAd() {
    return FacebookNativeAd(
      // placementId: "YOUR_PLACEMENT_ID",
      placementId: "IMG_16_9_APP_INSTALL#265036219221143_265037412554357",
      adType: NativeAdType.NATIVE_BANNER_AD,
      bannerAdSize: NativeBannerAdSize.HEIGHT_100,
      width: double.infinity,
      backgroundColor: Colors.blue,
      titleColor: Colors.white,
      descriptionColor: Colors.white,
      buttonColor: Colors.deepPurple,
      buttonTitleColor: Colors.white,
      buttonBorderColor: Colors.white,
      listener: (result, value) {
        print("Native Banner Ad: $result --> $value");
      },
    );
  }

  _showNativeAd() {
    setState(() {
      _currentAd = _nativeAd();
    });
  }

  Widget _nativeAd() {
    return FacebookNativeAd(
      placementId: "CAROUSEL_IMG_SQUARE_LINK#265036219221143_265037215887710",
      adType: NativeAdType.NATIVE_AD_VERTICAL,
      width: double.infinity,
      height: 300,
      backgroundColor: Colors.blue,
      titleColor: Colors.white,
      descriptionColor: Colors.white,
      buttonColor: Colors.deepPurple,
      buttonTitleColor: Colors.white,
      buttonBorderColor: Colors.white,
      listener: (result, value) {
        print("Native Ad: $result --> $value");
      },
      keepExpandedWhileLoading: true,
      expandAnimationDuraion: 1000,
    );
  }
}
