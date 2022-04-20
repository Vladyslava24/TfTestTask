import 'package:flutter/cupertino.dart';
import 'package:totalfit/model/sign_up_type.dart';

class SignInWithSocialRequest implements SignUpType {
  String provider;
  String accessToken;

  SignInWithSocialRequest({this.provider, this.accessToken});

  Map<String, dynamic> toMap() => {
        "provider": provider,
        "accessToken": accessToken
      };
}

class SocialType {
  static const GOOGLE = SocialType._(index: 1, name: "google");
  static const FACEBOOK = SocialType._(index: 2, name: "facebook");
  static const APPLE = SocialType._(index: 3, name: "apple");

  final int index;
  final String name;

  const SocialType._({@required this.index, @required this.name});

  static List<SocialType> _swap = [GOOGLE, FACEBOOK, APPLE];

  static SocialType byIndex(int index) {
    return _swap.firstWhere((element) => element.index == index);
  }
}
