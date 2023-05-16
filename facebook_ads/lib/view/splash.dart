import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'fb_ads/fb_ads.dart';

class LoadingSplash extends StatefulWidget {
  @override
  _LoadingSplashState createState() => _LoadingSplashState();
}

class _LoadingSplashState extends State<LoadingSplash> {
  checkAuth() async {
    await Future.delayed(Duration(seconds: 5), () {
      // adsController.appOpenAd!.dispose();
      Get.off(() => FbAdsPage());
    });
  }

  // final AdsController adsController = Get.put(AdsController());

  @override
  void initState() {
    super.initState();
    // adsController.createOpenAppAd();
    // adsController.createBannerAd();
    FacebookAudienceNetwork.init();

    checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  // textAlign: TextAlign.justify,
                  "Welcome to Ads Lovers App",
                  textScaleFactor: 1.5,
                ),
              ),
              Spacer(),
              CircularProgressIndicator(
                color: Colors.amber,
                backgroundColor: Colors.grey,
                strokeWidth: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
