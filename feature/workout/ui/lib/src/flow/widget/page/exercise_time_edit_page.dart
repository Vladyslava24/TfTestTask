import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:ui_kit/ui_kit.dart';

class ExerciseTimeEditPage extends StatefulWidget {
  final int initialDuration;
  final Function(int) onSubmitResult;

  const ExerciseTimeEditPage({
    required this.initialDuration,
    required this.onSubmitResult,
    Key? key
  }) : super(key: key);

  @override
  _ExerciseTimeEditPageState createState() => _ExerciseTimeEditPageState();
}

const inputLength = 4;

class _ExerciseTimeEditPageState extends State<ExerciseTimeEditPage> {
  late TextEditingController _textController;
  late FocusNode _focusNode;

  int _typedDigitPointer = inputLength;
  late String _resultTime;
  late int keyboardOpedListenerId;

  @override
  void initState() {
    _focusNode = FocusNode();
    final initialDuration = Duration(milliseconds: widget.initialDuration);
    _resultTime =
        '${twoDigits(initialDuration.inMinutes.remainder(60))}:${twoDigits(initialDuration.inSeconds.remainder(60))}';
    _textController = TextEditingController(text: _resultTime);
    _textController.addListener(() {
      if (_textController.text != _resultTime) {
        String typedChar = _textController.text.characters.last;
        if (!RegExp(r'^[0-9]+$').hasMatch(typedChar)) {
          _textController.value = TextEditingValue(
              text: _textController.text
                  .substring(0, _textController.text.length - 1),
              selection: TextSelection.fromPosition(
                  const TextPosition(offset: inputLength + 1)));
          return;
        }
        if (_textController.text.length < _resultTime.length) {
          _textController.value = TextEditingValue(
              text: _resultTime,
              selection: TextSelection.fromPosition(
                  const TextPosition(offset: inputLength + 1)));
          return;
        }
        String toUpdate = _textController.text.substring(0, inputLength + 1);

        if (_typedDigitPointer == 2) {
          _typedDigitPointer--;
        }

        toUpdate = _replaceCharAt(toUpdate, typedChar);
        _resultTime = toUpdate;

        _textController.value = TextEditingValue(
            text: toUpdate,
            selection: TextSelection.fromPosition(
                const TextPosition(offset: inputLength + 1)));
        _typedDigitPointer--;
        if (_typedDigitPointer < 0) {
          _typedDigitPointer = inputLength;
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }

  String _replaceCharAt(String oldString, String newChar) {
    oldString = oldString.replaceFirst(':', '');
    oldString = oldString.substring(1, oldString.length) + newChar;
    return oldString.substring(0, 2) +
        ':' +
        oldString.substring(2, oldString.length);
  }

  Widget _buildContent() {
    return Stack(children: [
      Positioned.fill(
        child: Column(
          children: <Widget>[
            Expanded(
                child: Container(
              color: AppColorScheme.colorBlack,
            )),
            Expanded(
                child: Container(
              color: AppColorScheme.colorBlack2,
            )),
          ],
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Material(
          color: AppColorScheme.colorBlack,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 16, left: 24, right: 24, bottom: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).your_result_is.toUpperCase(),
                            style: title20.copyWith(
                              color: AppColorScheme.colorPrimaryWhite,
                            ),
                          ),
                          Container(height: 12),
                          Container(
                            height: 80,
                            width: 160,
                            decoration: BoxDecoration(
                              color: AppColorScheme.colorBlack2,
                              borderRadius: BorderRadius.circular(10.0)),
                            child: Align(
                              alignment: Alignment.center,
                              child: KeyboardVisibilityBuilder(
                                builder: (context, isKeyboardVisible) {
                                  return Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (!isKeyboardVisible) {
                                            FocusScope.of(context)
                                              .requestFocus(_focusNode);
                                            _textController.value =
                                                TextEditingValue(
                                                  text: _textController.text,
                                                  selection: TextSelection.fromPosition(
                                                    const TextPosition(
                                                        offset: inputLength + 1),
                                                  ),
                                                );
                                          }
                                        },
                                        child: AbsorbPointer(
                                          child: TextField(
                                            textInputAction: TextInputAction.done,
                                            focusNode: _focusNode,
                                            showCursor: false,
                                            onSubmitted: (v) {
                                              _onSubmitResult();
                                            },
                                            style: title40.copyWith(
                                              color:
                                              AppColorScheme.colorPrimaryWhite,
                                            ),
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.center,
                                            controller: _textController,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: ActionButton(
                              padding: const EdgeInsets.only(
                                bottom: 16, left: 16, right: 8),
                              textColor: AppColorScheme.colorPrimaryWhite,
                              text: S.of(context).no_change.toUpperCase(),
                              color: AppColorScheme.colorBlack4,
                              onPressed: () {
                                FocusScope.of(context)
                                  .requestFocus(_focusNode);
                              }
                            ),
                          ),
                          Expanded(
                            child: ActionButton(
                              padding: const EdgeInsets.only(
                                bottom: 16, left: 8, right: 16),
                              text: S.of(context).yes.toUpperCase(),
                              color: AppColorScheme.colorYellow,
                              onPressed: () {
                                _onSubmitResult();
                              }
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  _onSubmitResult() {
    _focusNode.unfocus();
    int minutes = int.parse(_resultTime.substring(0, _resultTime.indexOf(':')));
    int seconds =
        int.parse(_resultTime.substring(_resultTime.indexOf(':') + 1));
    if (seconds > 59) {
      seconds = seconds - 60;
      if (minutes < 99) {
        minutes++;
      }
    }
    _resultTime = '${twoDigits(minutes)}:${twoDigits(seconds)}';
    _textController.value = TextEditingValue(
        text: _resultTime,
        selection: TextSelection.fromPosition(
            const TextPosition(offset: inputLength + 1)));

    final result = Duration(minutes: minutes, seconds: seconds).inMilliseconds;
    widget.onSubmitResult(result);
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
