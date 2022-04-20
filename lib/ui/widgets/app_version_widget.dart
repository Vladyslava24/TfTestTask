import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ui_kit/ui_kit.dart';

class AppVersionWidget extends StatelessWidget {
  const AppVersionWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return Text(
            "version: ${snapshot.data.version}",
            textAlign: TextAlign.center,
            style: textRegular12.copyWith(color: AppColorScheme.colorBlack7),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
