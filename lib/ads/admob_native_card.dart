import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// One native ad styled like a history card. Takes no space until an ad has
/// loaded, and none at all without a unit id or consent.
class AdMobNativeCard extends StatefulWidget {
  const AdMobNativeCard({
    super.key,
    required this.adUnitId,
    required this.canRequestAds,
  });

  final String? adUnitId;
  final bool canRequestAds;

  @override
  State<AdMobNativeCard> createState() => _AdMobNativeCardState();
}

class _AdMobNativeCardState extends State<AdMobNativeCard> {
  NativeAd? _ad;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _loadIfAllowed();
  }

  @override
  void didUpdateWidget(AdMobNativeCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.canRequestAds) {
      _disposeAd();
    } else if (!oldWidget.canRequestAds ||
        oldWidget.adUnitId != widget.adUnitId) {
      _disposeAd();
      _loadIfAllowed();
    }
  }

  void _loadIfAllowed() {
    final id = widget.adUnitId;
    if (id == null || !widget.canRequestAds || _ad != null) return;
    late final NativeAd ad;
    ad = NativeAd(
      adUnitId: id,
      request: const AdRequest(),
      // The SDK template draws the required "Ad" badge itself.
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.small,
        mainBackgroundColor: Colors.white,
        cornerRadius: 12,
      ),
      listener: NativeAdListener(
        onAdLoaded: (_) {
          if (!mounted || _ad != ad) return;
          setState(() => _loaded = true);
        },
        onAdFailedToLoad: (failed, error) {
          debugPrint('History native ad failed: ${error.code} ${error.message}');
          failed.dispose();
          if (!mounted || _ad != ad) return;
          setState(() {
            _ad = null;
            _loaded = false;
          });
        },
      ),
    );
    _ad = ad;
    ad.load();
  }

  void _disposeAd() {
    _ad?.dispose();
    _ad = null;
    _loaded = false;
  }

  @override
  void dispose() {
    _disposeAd();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ad = _ad;
    if (ad == null || !_loaded) return const SizedBox.shrink();
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      // Height the SDK's small template needs.
      child: SizedBox(height: 96, child: AdWidget(ad: ad)),
    );
  }
}
