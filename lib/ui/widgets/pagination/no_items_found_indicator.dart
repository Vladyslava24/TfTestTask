import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';

import 'first_page_exception_indicator.dart';

class NoItemsFoundIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => FirstPageExceptionIndicator(
        title: S.of(context).no_item_found,
        message: S.of(context).list_empty,
      );
}
