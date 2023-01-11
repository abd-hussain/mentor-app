// import 'package:client_app/utils/addsHelper.dart';
import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

class AddMobBanner extends StatefulWidget {
  const AddMobBanner({Key? key}) : super(key: key);

  @override
  State<AddMobBanner> createState() => _AddMobBannerState();
}

class _AddMobBannerState extends State<AddMobBanner> {
  // late BannerAd _bannerAd;
  // bool _isBannerAdReady = false;

  // @override
  // void initState() {
  //   _bannerAd = BannerAd(
  //     adUnitId: AdHelper.bannerAdUnitId,
  //     request: const AdRequest(),
  //     size: AdSize.banner,
  //     listener: BannerAdListener(
  //       onAdLoaded: (_) {
  //         setState(() {
  //           _isBannerAdReady = true;
  //         });
  //       },
  //       onAdFailedToLoad: (ad, err) {
  //         print('Failed to load a banner ad: ${err.message}');
  //         _isBannerAdReady = false;
  //         ad.dispose();
  //       },
  //     ),
  //   );

  //   _bannerAd.load();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return
        // _isBannerAdReady
        //     ? Padding(
        //         padding: const EdgeInsets.only(top: 8, bottom: 8),
        //         child: Align(
        //           alignment: Alignment.topCenter,
        //           child: SizedBox(
        //             width: _bannerAd.size.width.toDouble(),
        //             height: _bannerAd.size.height.toDouble(),
        //             child: AdWidget(ad: _bannerAd),
        //           ),
        //         ),
        //       )
        //     :
        Container();
  }
}
