import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class TfDialogAttributes {
  String? title;
  String? description;
  String? negativeText;
  String? positiveText;

  TfDialogAttributes({this.title, this.description, this.positiveText, this.negativeText});
}

class TfDialog {
  static show<DialogResult>(BuildContext context, TfDialogAttributes attrs) async {
    final actionList = <CupertinoDialogAction>[];
    if (attrs.negativeText != null) {
      actionList.add(
        CupertinoDialogAction(
          textStyle: textRegular14.copyWith(
            color: AppColorScheme.colorYellow,
          ),
          child: Text(
            attrs.negativeText!.toUpperCase(),
          ),
          onPressed: () {
            return Navigator.of(context).pop(Cancel());
          },
        ),
      );
    }
    if (attrs.positiveText != null) {
      actionList.add(CupertinoDialogAction(
        textStyle: textRegular14.copyWith(
          color: AppColorScheme.colorYellow,
        ),
        child: Text(attrs.positiveText!.toUpperCase()),
        onPressed: () {
          return Navigator.of(context).pop(Confirm());
        },
      ));
    }
    return showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return Theme(
          data: ThemeData.dark(),
          child: CupertinoAlertDialog(
              title: attrs.title == null ? null : Text(attrs.title!, style: title16),
              content: attrs.description != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        attrs.description!,
                        style: textRegular14.copyWith(
                          color: AppColorScheme.colorBlack9,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              actions: actionList),
        );
      },
    );
  }
}

abstract class DialogResult {}

class Cancel implements DialogResult {}

class Confirm implements DialogResult {}
