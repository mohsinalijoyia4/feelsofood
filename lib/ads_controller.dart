import 'dart:io';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MyController extends GetxController {
  NativeAd? nativeAd;
  RxBool isAdLoaded = false.obs;
  final String adUnitId = "ca-app-pub-3940256099942544/2247696110";
  loadAd() {
    nativeAd = NativeAd(
        adUnitId: adUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            isAdLoaded.value = true;
          },
          onAdFailedToLoad: (ad, error) {
            isAdLoaded.value = false;
          },
        ),
        request: AdRequest(),
        nativeTemplateStyle:
            NativeTemplateStyle(templateType: TemplateType.small));
    nativeAd!.load();
  }

  @override
  void dispose() {
    nativeAd?.dispose();
    super.dispose();
  }
}

class MyControllerHome extends GetxController {
  NativeAd? nativeAd;
  RxBool isAdLoaded = false.obs;
  final String androidAdUnitId = "ca-app-pub-3940256099942544/2247696110";
  final String iosAdUnitId = "ca-app-pub-6092802048217588/9586725681";
  loadAd() {
    nativeAd = NativeAd(
        adUnitId: Platform.isAndroid ? androidAdUnitId : iosAdUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            isAdLoaded.value = true;
          },
          onAdFailedToLoad: (ad, error) {
            isAdLoaded.value = false;
          },
        ),
        request: AdRequest(),
        nativeTemplateStyle:
            NativeTemplateStyle(templateType: TemplateType.small));
    nativeAd!.load();
  }

  @override
  void dispose() {
    nativeAd?.dispose();
    super.dispose();
  }
}

class MyControllerSetting extends GetxController {
  NativeAd? nativeAd;
  RxBool isAdLoaded = false.obs;
  final String adUnitId = "ca-app-pub-3940256099942544/2247696110";
  loadAd() {
    nativeAd = NativeAd(
        adUnitId: adUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            isAdLoaded.value = true;
          },
          onAdFailedToLoad: (ad, error) {
            isAdLoaded.value = false;
          },
        ),
        request: AdRequest(),
        nativeTemplateStyle:
            NativeTemplateStyle(templateType: TemplateType.small));
    nativeAd!.load();
  }

  @override
  void dispose() {
    nativeAd?.dispose();
    super.dispose();
  }
}
