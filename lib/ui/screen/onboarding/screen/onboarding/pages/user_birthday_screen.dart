import 'dart:async';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:core/generated/l10n.dart';
import 'package:ui_kit/ui_kit.dart';

class UserBirthdayScreen extends StatefulWidget {
  final Function(String) onNext;

  UserBirthdayScreen({@required this.onNext});

  @override
  _UserBirthdayScreenState createState() => _UserBirthdayScreenState();
}

class _UserBirthdayScreenState extends State<UserBirthdayScreen> {
  String _resultDate = '';
  String _dateValidationError;
  TextEditingController _textController;

  @override
  void initState() {
    _textController = TextEditingController();
    _textController.addListener(() {
      setState(() {
        _dateValidationError = null;
        _resultDate = _textController.value.text;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColorScheme.colorPrimaryBlack,
        child: Column(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(S.of(context).onboarding_user_birthday_screen_title,
                  style: title30.copyWith(fontFamily: 'Gilroy'), textAlign: TextAlign.left),
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  TextFormField(
                    controller: _textController,
                    showCursor: false,
                    inputFormatters: [MaskedTextInputFormatter(mask: 'xx-xx-xx', separator: "-")],
                    textInputAction: TextInputAction.done,
                    maxLength: 8,
                    style: title30.copyWith(color: AppColorScheme.colorBlack8),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintStyle: title30.copyWith(color: AppColorScheme.colorBlack8),
                        hintText: 'MM.DD.YY',
                        errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColorScheme.colorRed)),
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColorScheme.colorBlack7)),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColorScheme.colorYellow))),
                  ),
                  AnimatedOpacity(
                    opacity: _dateValidationError != null ? 1.0 : 0.0,
                    child: _dateValidationError != null
                        ? Text(_dateValidationError, style: textRegular14.copyWith(color: Colors.red))
                        : SizedBox.shrink(),
                    duration: Duration(milliseconds: 200),
                  ),
                ]),
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: BaseElevatedButton(
              text: S.of(context).all__continue,
              onPressed: () {
                int _typedDigitPointer = 0;
                bool isValid = true;
                while (_typedDigitPointer < _validationRules.length) {
                  final rule = _validationRules[_typedDigitPointer];
                  _typedDigitPointer++;
                  if (!rule.call(_resultDate)) {
                    isValid = false;
                    break;
                  }
                }

                if (isValid) {
                  Future.delayed(Duration(milliseconds: 100), () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (mounted) {
                      final serverFormattedDate = _getServerFormattedDate(_resultDate);
                      widget.onNext(serverFormattedDate);
                    }
                  });
                } else {
                  setState(() {
                    _dateValidationError = 'Incorrect Date';
                  });
                }
              },
              isEnabled: _isInputValid(),
            ),
          )
        ]));
  }

  final _numericRegex = RegExp(r'^-?(([0-9]{2}).(([0-9]{2}).([0-9]{2})))$');

  bool _isInputValid() {
    return _numericRegex.hasMatch(_textController.value.text);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

class MaskedTextInputFormatter extends TextInputFormatter {
  String _mask;
  String _separator;

  MaskedTextInputFormatter({@required String mask, @required String separator}) {
    _separator = (separator != null && separator.isNotEmpty) ? separator : null;
    if (mask != null && mask.isNotEmpty) {
      _mask = mask;
    }
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;
    final oldText = oldValue.text;

    if (newText.length == 0 || newText.length < oldText.length || _mask == null || _separator == null) {
      return newValue;
    }

    if (newText.length < _mask.length && _mask[newText.length - 1] == _separator) {
      final text = '$oldText$_separator${newText.substring(newText.length - 1)}';
      return TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(
          offset: text.length,
        ),
      );
    }

    return newValue;
  }
}

String _getServerFormattedDate(String date) {
  ///ui format - 'MM.DD.YY'
  String month = date.substring(0, 2);
  String day = date.substring(3, 5);
  String year = date.substring(6);

  final now = DateTime.now();
  final DateFormat formatter = DateFormat('yy');
  int currentYear = int.parse(formatter.format(now));

  int typedYear = int.parse(year);
  int formattedYear;
  if (typedYear >= 00 && typedYear < currentYear) {
    formattedYear = 2000 + typedYear;
  } else {
    formattedYear = 1900 + typedYear;
  }

  /// server format - 'yyyy-MM-dd'
  return '$formattedYear-$month-$day';
}

final _validationRules = <int, Function>{
  //first month digit
  0: (source) {
    int firstDigit = int.parse(source[0]);
    return firstDigit <= 1;
  },
  //second month digit
  1: (source) {
    int firstDigit = int.parse(source[0]);
    int secondDigit = int.parse(source[1]);
    String typedChar;
    if (firstDigit == 0 && secondDigit > 9) {
      return false;
    } else if (firstDigit == 1 && secondDigit > 2) {
      return false;
    }
    return true;
  },
  2: (source) {
    int typedDay = int.parse(source.substring(0, 2));
    if (typedDay == 0) {
      source = source.replaceRange(0, 2, '01');
    }

    int typedNumber = int.parse(source[3]);
    int month = int.parse(source.substring(0, 2));
    if (month == 2 && typedNumber > 2) {
      return false;
    } else if (typedNumber > 3) {
      return false;
    }
    return true;
  },
  3: (source) {
    int firstNumber = int.parse(source[3]);
    int typedSecondNumber = int.parse(source[4]);
    int month = int.parse(source.substring(0, 2));

    if (month == 1) {
      if (firstNumber == 3 && typedSecondNumber > 1) {
        return false;
      }
    } else if (month == 2) {
      //do nothing
    } else if (month == 3) {
      if (firstNumber == 3 && typedSecondNumber > 1) {
        return false;
      }
    } else if (month == 4) {
      if (firstNumber == 3 && typedSecondNumber > 0) {
        return false;
      }
    } else if (month == 5) {
      if (firstNumber == 3 && typedSecondNumber > 1) {
        return false;
      }
    } else if (month == 6) {
      if (firstNumber == 3 && typedSecondNumber > 0) {
        return false;
      }
    } else if (month == 7) {
      if (firstNumber == 3 && typedSecondNumber > 1) {
        return false;
      }
    } else if (month == 8) {
      if (firstNumber == 3 && typedSecondNumber > 1) {
        return false;
      }
    } else if (month == 9) {
      if (firstNumber == 3 && typedSecondNumber > 0) {
        return false;
      }
    } else if (month == 10) {
      if (firstNumber == 3 && typedSecondNumber > 1) {
        return false;
      }
    } else if (month == 11) {
      if (firstNumber == 3 && typedSecondNumber > 0) {
        return false;
      }
    } else {
      if (firstNumber == 3 && typedSecondNumber > 1) {
        return false;
      }
    }

    return true;
  },
  4: (source) {
    int typedDate = int.parse(source.substring(3, 5));
    if (typedDate == 0) {
      return false;
    }

    return true;
  },
  5: (source) {
    final now = DateTime.now();
    final DateFormat formatter = DateFormat('yy');
    int currentYear = int.parse(formatter.format(now));

    String typedChar = source[7];

    int typedYear = int.parse(source.substring(6, 8));
    int checkYear;
    if (typedYear >= 00 && typedYear < currentYear) {
      checkYear = 2000 + typedYear;
    } else {
      checkYear = 1900 + typedYear;
    }

    if (!_isLeapYear(checkYear)) {
      int typedMonth = int.parse(source.substring(0, 2));
      int typedDate = int.parse(source.substring(3, 5));

      if (typedMonth == 2 && typedDate > 28) {
        return false;
      }
    }

    return true;
  },
};

bool _isLeapYear(int year) {
  if (year % 4 == 0) {
    if (year % 100 == 0) {
      if (year % 400 == 0) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  } else {
    return false;
  }
}
