import 'package:facebook_ads/controller/fb_ads_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'fb_ads_example.dart';

class FbAdsPage extends StatelessWidget {
  final FbAdsController fbAdsController = Get.put(FbAdsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FB Ads'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text('FB Ads Page'),
          TextButton(
            onPressed: () {
              Get.to(() {
                print('Interstitial ads btn pressed...');
                fbAdsController.showInterstitialAd();
              });
            },
            child: Text('Show Interstitial Ads'),
          ),
          TextButton(
            onPressed: () {
              Get.to(() {
                print('Rewarded ads btn pressed...');
                AdExampleApp();
              });
            },
            child: Text('Show fb Ads example'),
          ),
        ],
      ),
    );
  }
}
