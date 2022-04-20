

class Link {}

class EmptyLink implements Link {}

class MainPageLink implements Link {}

class ResetPasswordLink implements Link {
  final String userTokenUuid;

  ResetPasswordLink({this.userTokenUuid});
}
