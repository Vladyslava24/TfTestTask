library ui;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:url_launcher/url_launcher.dart';

class UpgradeVersionScreen {
  static show(String storeURL, AppNavigator appNavigator) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _showOverlay(appNavigator, storeURL);
    });
  }
}

void _showOverlay(AppNavigator appNavigator, String storeURL) async {
  OverlayState? overlayState = appNavigator.navigationContext.overlay;
  OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(builder: (context) {
    return Material(
      color: AppColorScheme.colorBlack2,
      child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const Expanded(child: SizedBox.shrink()),
                SvgPicture.asset(
                  iconUpgrade,
                  color: AppColorScheme.colorBlue2,
                ),
                const SizedBox(
                  height: 96,
                ),
                Column(
                  children: [
                    Text(_Constants.title, style: title20),
                    const SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        _Constants.message,
                        style: textRegular16.copyWith(height: 1.5),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ActionButton(
                      padding: EdgeInsets.zero,
                      text: _Constants.buttonText.toUpperCase(),
                      textColor: AppColorScheme.colorPrimaryWhite,
                      color: AppColorScheme.colorBlue2,
                      onPressed: () {
                        _toAppStore(storeURL);
                      },
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  });

  overlayState?.insert(overlayEntry);
}

void _toAppStore(String? appStoreURL) async {
  if (appStoreURL == null || appStoreURL.isEmpty) {
    return;
  }

  if (await canLaunch(appStoreURL)) {
    try {
      await launch(appStoreURL);
    } catch (e) {
      //ignore
    }
  } else {}
}

class _Constants {
  static const String title = 'We’re better than ever';
  static const String message =
      'A new version of Totalfit is available and is required to continue. Please update to latest version.';
  static const String buttonText = 'Upgrade';
}
