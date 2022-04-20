import 'package:flutter/material.dart';

import 'first_page_exception_indicator.dart';

class FirstPageErrorIndicator extends StatelessWidget {
  final VoidCallback onTryAgain;
  final String errorTitle;
  final String errorMessage;

  const FirstPageErrorIndicator(
      {@required this.errorTitle, @required this.errorMessage, @required this.onTryAgain, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) =>
      FirstPageExceptionIndicator(title: errorTitle, message: errorMessage, onTryAgain: onTryAgain);
}
