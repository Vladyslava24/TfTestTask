import 'dart:io';

import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';

enum Reason { Body, Mind, Spirit }

Reason fromBackendKey(String key) {
  if (key == 'WORKOUTS') {
    return Reason.Body;
  } else if (key == 'MIND_DEVELOPMENT') {
    return Reason.Mind;
  } else if (key == 'GETTING_CALM') {
    return Reason.Spirit;
  }
  return null;
}

extension ReasonX on Reason {
  String toBackendKey() {
    switch (this) {
      case Reason.Body:
        return 'WORKOUTS';
      case Reason.Mind:
        return 'MIND_DEVELOPMENT';
      case Reason.Spirit:
        return 'GETTING_CALM';
      default:
        return "";
    }
  }

  String getTitle(BuildContext context) {
    return Platform.isIOS ? getIosTitle(context) : getAndroidTitle(context);
  }

  String getSubTitle(BuildContext context) {
    return Platform.isIOS ? getIosSubTitle(context) : getAndroidSubTitle(context);
  }

  String getIosTitle(BuildContext context) {
    switch (this) {
      case Reason.Body:
        return S.of(context).reason_body_title_ios;
      case Reason.Mind:
        return S.of(context).reason_mind_title_ios;
      case Reason.Spirit:
        return S.of(context).reason_spirit_title_ios;
      default:
        return "";
    }
  }

  String getIosSubTitle(BuildContext context) {
    switch (this) {
      case Reason.Body:
        return S.of(context).reason_body_subtitle_ios;
      case Reason.Mind:
        return S.of(context).reason_mind_subtitle_ios;
      case Reason.Spirit:
        return S.of(context).reason_spirit_subtitle_ios;
      default:
        return "";
    }
  }

  String getIcon() {
    switch (this) {
      case Reason.Body:
        return '💪️️';
      case Reason.Mind:
        return '🧠';
      case Reason.Spirit:
        return '🧘‍♂️';
      default:
        return "";
    }
  }

  String getAndroidTitle(BuildContext context) {
    switch (this) {
      case Reason.Body:
        return S.of(context).reason_body_title_android;
      case Reason.Mind:
        return S.of(context).reason_mind_title_android;
      case Reason.Spirit:
        return S.of(context).reason_spirit_title_android;
      default:
        return "";
    }
  }

  String getAndroidSubTitle(BuildContext context) {
    switch (this) {
      case Reason.Body:
        return S.of(context).reason_body_subtitle_android;
      case Reason.Mind:
        return S.of(context).reason_mind_subtitle_android;
      case Reason.Spirit:
        return S.of(context).reason_spirit_subtitle_android;
      default:
        return "";
    }
  }
}
