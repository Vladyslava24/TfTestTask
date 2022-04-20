class FacebookSignUp implements SignUpType {}

class GoogleSignUp implements SignUpType {}

class AppleSignUp implements SignUpType {}

abstract class SignUpType {
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
