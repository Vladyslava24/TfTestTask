import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:simple_tooltip/simple_tooltip.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/loading_state/statement_page_state.dart';
import 'package:totalfit/redux/actions/progress_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:ui_kit/ui_kit.dart';

class StatementPage extends StatefulWidget {
  final int progressPageIndex;

  StatementPage({this.progressPageIndex});

  @override
  _StatementPageState createState() => _StatementPageState();
}

class _StatementPageState extends State<StatementPage> {
  TextEditingController _textEditingController;
  bool _showTooltip;
  bool _showProgress;
  Function _recentUpdateStoryRequest;

  @override
  void initState() {
    _showTooltip = false;
    _showProgress = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      onInit: (store) {
        _textEditingController = TextEditingController(text: "");
      },
      onWillChange: (oldVm, newVm) {
        if (oldVm.statementPageState != StatementPageState.LOADING &&
            newVm.statementPageState == StatementPageState.LOADING) {
          _showProgress = true;
        }
        if (oldVm.statementPageState == StatementPageState.LOADING &&
            newVm.statementPageState != StatementPageState.LOADING) {
          _showProgress = false;
        }
        if (!oldVm.statementPageState.isError() && newVm.statementPageState.isError()) {
          final attrs = TfDialogAttributes(
            title: S.of(context).dialog_error_title,
            description: newVm.statementPageState.getErrorMessage(),
            negativeText: S.of(context).dialog_error_recoverable_negative_text,
            positiveText: S.of(context).all__retry,
          );
          TfDialog.show(context, attrs).then((r) {
            if (r is Cancel) {
              Navigator.of(context).pop();
            } else {
              _recentUpdateStoryRequest.call();
            }
          });
        }
      },
      onDispose: (store) {
        _textEditingController.dispose();
      },
      builder: (context, vm) => _buildContent(vm),
    );
  }

  Widget _buildContent(_ViewModel vm) {
    return Stack(
      children: [
        Positioned.fill(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: AppColorScheme.colorBlack,
                ),
              ),
              Expanded(
                child: Container(
                  color: AppColorScheme.colorBlack2,
                ),
              ),
            ],
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Material(
              color: AppColorScheme.colorBlack,
              child: Column(
                children: <Widget>[
                  _buildHeaderWidget(),
                  _buildContentWidget(vm),
                ],
              ),
            ),
          ),
        ),
        _showProgress
            ? Positioned.fill(
                child: Container(
                  color: AppColorScheme.colorPrimaryBlack,
                  child: CircularLoadingIndicator(),
                ),
              )
            : Container()
      ],
    );
  }

  _showToolTip() {
    if (mounted) {
      setState(() {
        _showTooltip = !_showTooltip;
      });
    }
  }

  Widget _buildContentWidget(_ViewModel vm) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        child: Container(
          color: AppColorScheme.colorBlack2,
          alignment: Alignment.centerLeft,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 16, left: 24, right: 24, bottom: 16),
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    expands: true,
                    onChanged: (_) {
                      setState(() {});
                    },
                    readOnly: false,
                    maxLines: null,
                    style: textRegular16.copyWith(
                      color: AppColorScheme.colorPrimaryWhite,
                    ),
                    keyboardType: TextInputType.text,
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintMaxLines: 2,
                      hintText: S.of(context).write_simple_action,
                      hintStyle: textRegular16.copyWith(
                        color: AppColorScheme.colorBlack7,
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: ActionButton(
                            padding: EdgeInsets.only(bottom: 16, left: 16, right: 8),
                            textColor: AppColorScheme.colorPrimaryWhite,
                            text: S.of(context).all__skip.toUpperCase(),
                            color: AppColorScheme.colorBlack4,
                            onPressed: () {
                              _recentUpdateStoryRequest = () => vm.onSkipPressed(widget.progressPageIndex);
                              _recentUpdateStoryRequest.call();
                            }),
                      ),
                      Expanded(
                        child: ActionButton(
                            padding: EdgeInsets.only(bottom: 16, left: 8, right: 16),
                            textColor: AppColorScheme.colorPrimaryWhite,
                            text: S.of(context).done.toUpperCase(),
                            color: _textEditingController.text.isEmpty
                                ? AppColorScheme.colorBlue
                                : AppColorScheme.colorBlue2,
                            onPressed: () {
                              if (_textEditingController.text.isEmpty) {
                                return;
                              }
                              if (MediaQuery.of(context).viewInsets.bottom != 0) {
                                FocusScope.of(context).requestFocus(FocusNode());

                                Future.delayed(Duration(milliseconds: 150), () {
                                  _recentUpdateStoryRequest =
                                      () => vm.onDone(widget.progressPageIndex, _textEditingController.text);
                                  _recentUpdateStoryRequest.call();
                                });
                              } else {
                                _recentUpdateStoryRequest =
                                    () => vm.onDone(widget.progressPageIndex, _textEditingController.text);
                                _recentUpdateStoryRequest.call();
                              }
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderWidget() {
    return Container(
      height: 150,
      padding: EdgeInsets.all(24),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              S.of(context).what_does_story_motivate.toUpperCase(),
              maxLines: 2,
              style: title20.copyWith(
                color: AppColorScheme.colorPrimaryWhite,
              ),
            ),
          ),
          Container(
            width: 12,
          ),
          _buildHelpWidget()
        ],
      ),
    );
  }

  Widget _buildHelpWidget() {
    return SimpleTooltip(
      tooltipTap: () {
        _showToolTip();
      },
      animationDuration: Duration.zero,
      tooltipDirection: TooltipDirection.left,
      borderColor: Colors.transparent,
      maxWidth: MediaQuery.of(context).size.width * 0.8,
      arrowTipDistance: 0,
      arrowLength: 12,
      ballonPadding: EdgeInsets.all(0),
      content: Material(
        child: Text(
          S.of(context).i_will_statement_will_help_you,
          textAlign: TextAlign.center,
          style: textRegular16.copyWith(
            color: AppColorScheme.colorBlack5,
          ),
        ),
      ),
      show: _showTooltip,
      child: GestureDetector(
        onTap: () {
          _showToolTip();
        },
        child: Icon(
          Icons.info,
          color: AppColorScheme.colorBlue2,
          size: 24,
        ),
      ),
    );
  }
}

class _ViewModel {
  Function(int) onSkipPressed;
  Function(int, String) onDone;
  StatementPageState statementPageState;

  _ViewModel({@required this.statementPageState, @required this.onSkipPressed, @required this.onDone});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      statementPageState: store.state.mainPageState.statementPageState,
      onSkipPressed: (index) {
        store.dispatch(SaveStoryResultAction(progressPageIndex: index));
        store.dispatch(SendStatementSkippedEventAction());
      },
      onDone: (index, statement) {
        store.dispatch(SaveStoryResultAction(progressPageIndex: index, statement: statement));
        store.dispatch(SendStatementAddedEventAction(statement));
      },
    );
  }
}
