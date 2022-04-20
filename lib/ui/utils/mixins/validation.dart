mixin ValidationMixin {
  bool isFieldEmpty(String fieldValue) => fieldValue?.isEmpty ?? false;

  bool isHasEnoughLength(String fieldValue) => fieldValue.length < 6 ?? false;

  bool isValidEmailAddress(String email) {
    if (email == null) { return false; }

    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);
  }
}