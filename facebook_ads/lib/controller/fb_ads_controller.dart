import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:get/get.dart';

class FbAdsController extends GetxController {
  bool isInterstitialAdLoaded = false;
  bool isRewardedAdLoaded = false;
  @override
  void onInit() {
    loadInterstitialAd();
    // loadRewardedVideoAd();
    super.onInit();
  }

  @override
  void dispose() {
    // loadInterstitialAd.
    super.dispose();
  }

  void loadInterstitialAd() {
    FacebookInterstitialAd.loadInterstitialAd(
      // placementId: "YOURPLACEMENTID",
      placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617",
      listener: (result, value) {
        // print(">> FAN > Interstitial Ad: $result --> $value");
        if (result == InterstitialAdResult.LOADED)
          isInterstitialAdLoaded = true;

        /// Once an Interstitial Ad has been dismissed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {
          isInterstitialAdLoaded = false;
          loadInterstitialAd();
        }
      },
    );
  }

  showInterstitialAd() {
    if (isInterstitialAdLoaded == true)
      FacebookInterstitialAd.showInterstitialAd();
    else
      print("Interstitial Ad not yet loaded!");
  }

  void loadRewardedVideoAd() {
    FacebookRewardedVideoAd.loadRewardedVideoAd(
      placementId: "YOUR_PLACEMENT_ID",
      listener: (result, value) {
        // print("Rewarded Ad: $result --> $value");
        if (result == RewardedVideoAdResult.LOADED) isRewardedAdLoaded = true;
        if (result == RewardedVideoAdResult.VIDEO_COMPLETE)

        /// Once a Rewarded Ad has been closed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == RewardedVideoAdResult.VIDEO_CLOSED &&
            (value == true || value["invalidated"] == true)) {
          isRewardedAdLoaded = false;
          loadRewardedVideoAd();
        }
      },
    );
  }
}
