import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:ui_kit/ui_kit.dart';

class DatePickerInputField extends StatefulWidget {
  final String errorMessage;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final ValueNotifier<DateTime> dateNotifier;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final Function(String) onChanged;
  final Function onClearError;
  final String label;

  DatePickerInputField(
      {this.errorMessage,
      this.focusNode,
      this.nextFocusNode,
      this.dateNotifier,
      this.textEditingController,
      this.keyboardType,
      this.onChanged,
      this.onClearError,
      this.label});

  @override
  _DatePickerInputFieldState createState() => _DatePickerInputFieldState();
}

class _DatePickerInputFieldState extends State<DatePickerInputField> {
  Function _focusListener;

  @override
  void initState() {
    _focusListener = () {
      if (widget.focusNode.hasFocus) {
        _showNativeDatePicker();
      }
    };
    widget.focusNode.addListener(_focusListener);
    super.initState();
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_focusListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      child: Container(
        alignment: Alignment.centerLeft,
        child: TextFormField(
          showCursor: false,
          readOnly: true,
          textInputAction: widget.nextFocusNode != null
              ? TextInputAction.next
              : TextInputAction.done,
          onTap: () {
            _showNativeDatePicker();
          },
          style:
              textRegular16.copyWith(color: AppColorScheme.colorPrimaryWhite),
          keyboardType: widget.keyboardType,
          controller: widget.textEditingController,
          decoration: InputDecoration(
            hintText: widget.label,
            hintStyle:
                textRegular16.copyWith(color: AppColorScheme.colorBlack7),
            errorText: _setErrorText(),
            errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColorScheme.colorRed)),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColorScheme.colorBlack7),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColorScheme.colorYellow),
            ),
          ),
          onChanged: (text) {
            if (widget.errorMessage.isNotEmpty) {
              widget.onClearError();
            }
            widget.onChanged(text);
          },
        ),
      ),
    );
  }

  _showNativeDatePicker() {
    if (Platform.isIOS) {
      _showIosDatePicker();
    } else {
      _showMaterialDatePicker();
    }
  }

  DateTime _selectedDate;

  _showIosDatePicker() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    final result = await showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
              height: MediaQuery.of(context).copyWith().size.height / 3,
              child: CupertinoDatePicker(
                initialDateTime: widget.textEditingController.text.isEmpty
                    ? DateTime.now()
                    : DateTime.parse(
                        ensureValidFormat(widget.textEditingController.text)),
                onDateTimeChanged: (DateTime newDate) {
                  _selectedDate = newDate;
                },
                mode: CupertinoDatePickerMode.date,
              ));
        });
    if (_selectedDate != null) {
      _setSelectedDate(_selectedDate);
    }
  }

  void _setSelectedDate(DateTime dateTime) {
    if (dateTime != null) {
      if (widget.dateNotifier != null) {
        widget.dateNotifier.value = dateTime;
      }

      final formattedDate = unifiedUiDateFormat(dateTime);
      widget.textEditingController.text = formattedDate;
    }
    FocusScope.of(context).requestFocus(widget.nextFocusNode);
  }

  _showMaterialDatePicker() async {
    FocusScope.of(context).requestFocus(FocusNode());
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    ).then((value) => value != null ?
      widget.onChanged(unifiedUiDateFormat(value)): null);
    _setSelectedDate(selectedDate);
  }

  String _setErrorText() {
    return widget.errorMessage != null && widget.errorMessage.isNotEmpty
        ? widget.errorMessage
        : null;
  }
}
