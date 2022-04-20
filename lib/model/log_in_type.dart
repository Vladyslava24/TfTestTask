class FacebookLogIn implements LoginType {}

class GoogleLogIn implements LoginType {}

class AppleLogIn implements LoginType {}

abstract class LoginType {
  @override
  bool operator ==(other) {
    return runtimeType == (other.runtimeType);
  }

  @override
  int get hashCode => runtimeType.toString().hashCode;

  @override
  String toString() {
    return runtimeType.toString();
  }
}
