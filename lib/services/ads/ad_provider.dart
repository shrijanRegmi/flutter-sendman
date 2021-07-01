import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdProvider extends ChangeNotifier {
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  late BannerAd _bannerAd;
  bool _isBannerLoaded = false;

  InterstitialAd? get interstitialAd => _interstitialAd;
  RewardedAd? get rewardedAd => _rewardedAd;
  BannerAd get bannerAd => _bannerAd;
  bool get isBannerLoaded => _isBannerLoaded;
  // String get bannerId => 'ca-app-pub-3940256099942544/6300978111'; // test ad
  String get bannerId => 'ca-app-pub-1736091010557588/1450065191';
  // String get interstitialId => 'ca-app-pub-3940256099942544/1033173712'; // test ad
  String get interstitialId => 'ca-app-pub-1736091010557588/5197738516';
  // String get rewardedId => 'ca-app-pub-3940256099942544/5224354917'; // test ad
  String get rewardedId => 'ca-app-pub-1736091010557588/5006166827';

  // on dispose
  void onDispose() {
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
  }

  // get banner ad
  void loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: '$bannerId',
      size: AdSize.fullBanner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          _isBannerLoaded = true;
          notifyListeners();
        },
      ),
    );
    notifyListeners();

    _bannerAd.load();
  }

  // load interstitial ad
  Future<void> loadInterstitialAd() async {
    return await InterstitialAd.load(
      adUnitId: '$interstitialId',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print('$ad loaded');
          _interstitialAd = ad;
          notifyListeners();
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  // show interstitial ad
  Future<void> showInterstitialAd({
    final bool forced = false,
  }) async {
    bool _show = forced;

    if (!forced) {
      final _rand = Random();
      final _randNum = _rand.nextInt(100);
      _show = _randNum >= 70;

      print("RANDOM: $_randNum");
    }

    if (_show) await _interstitialAd?.show();

    loadInterstitialAd();
  }

  // load rewarded ad
  Future<void> loadRewardedAd() async {
    return await RewardedAd.load(
      adUnitId: '$rewardedId',
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          print('$ad loaded.');
          _rewardedAd = ad;
          notifyListeners();
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedAd failed to load: $error');
        },
      ),
    );
  }

  // show rewarded ad
  Future<void> showRewardedAd() async {
    return await _rewardedAd?.show(
      onUserEarnedReward: (RewardedAd ad, RewardItem item) {
        onRewarded();
      },
    );
  }

  // on rewarded function
  void onRewarded() {
    print("REWARDED");
  }
}
