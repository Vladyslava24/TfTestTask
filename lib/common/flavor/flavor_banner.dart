import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ui_kit/ui_kit.dart';

import 'flavor_config.dart';

class FlavorBanner extends StatefulWidget {
  final Widget child;
  final Color color;

  final BannerLocation bannerLocation;

  FlavorBanner({Key key, this.child, this.color, this.bannerLocation});

  @override
  _FlavorBannerState createState() => _FlavorBannerState();
}

class _FlavorBannerState extends State<FlavorBanner> {
  Future _future;

  @override
  void initState() {
    _future = PackageInfo.fromPlatform();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (FlavorConfig.instance == null || (FlavorConfig.instance.name == null || FlavorConfig.instance.name.isEmpty)) {
      return widget.child;
    }

    return FutureBuilder<PackageInfo>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return Directionality(
            textDirection: TextDirection.ltr,
            child: Banner(
              color: widget.color ?? AppColorScheme.colorYellow,
              message: 'v: ${snapshot.data.version}',
              location: widget.bannerLocation != null ? widget.bannerLocation : BannerLocation.bottomStart,
              child: widget.child,
              textStyle: TextStyle(
                color: AppColorScheme.colorBlack2,
                fontSize: 12.0 * 0.85,
                fontWeight: FontWeight.w900,
                height: 1.0,
              ),
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
