import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/loading_state/wisdom_page_state.dart';
import 'package:totalfit/model/wisdom_model.dart';
import 'package:totalfit/redux/actions/progress_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:ui_kit/ui_kit.dart';

class WisdomPage extends StatefulWidget {
  final int progressPageIndex;

  WisdomPage({@required this.progressPageIndex});

  @override
  _WisdomPageState createState() => _WisdomPageState();
}

class _WisdomPageState extends State<WisdomPage> {
  bool _showProgress;
  Function _recentUpdateWisdomRequest;
  ScrollController _controller;

  @override
  void initState() {
    _showProgress = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: (store) => _ViewModel.fromStore(store, widget.progressPageIndex),
      onWillChange: (oldVm, newVm) {
        if (oldVm.wisdomPageState != WisdomPageState.LOADING && newVm.wisdomPageState == WisdomPageState.LOADING) {
          _showProgress = true;
        }
        if (oldVm.wisdomPageState == WisdomPageState.LOADING && newVm.wisdomPageState != WisdomPageState.LOADING) {
          _showProgress = false;
        }
        if (!oldVm.wisdomPageState.isError() && newVm.wisdomPageState.isError()) {
          final attrs = TfDialogAttributes(
            title: S.of(context).dialog_error_title,
            description: newVm.wisdomPageState.getErrorMessage(),
            negativeText: S.of(context).dialog_error_recoverable_negative_text,
            positiveText: S.of(context).all__retry,
          );
          TfDialog.show(context, attrs).then((r) {
            if (r is Cancel) {
              Navigator.of(context).pop();
            } else {
              _recentUpdateWisdomRequest.call();
            }
          });
        }
      },
      onInit: (store) {
        _controller = ScrollController();
      },
      onDispose: (store) {
        _controller.dispose();
      },
      builder: (context, vm) => _buildContent(vm),
    );
  }

  Widget _buildContent(_ViewModel vm) {
    return Scaffold(
      backgroundColor: AppColorScheme.colorBlack,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: CustomSliverAppBar(
          backButtonIcon: IconBackWidget(
            iconColor: AppColorScheme.colorPurple2,
            action: () => Navigator.of(context).pop(),
          ),
          sliverContent: SliverToBoxAdapter(child: _buildText(vm.model.text)),
          extraOverlayContent: Stack(
            children: [
              _buildButton(vm),
              _showProgress
                  ? Positioned.fill(
                      child: Container(
                        color: AppColorScheme.colorPrimaryBlack,
                        child: CircularLoadingIndicator(),
                      ),
                    )
                  : Container()
            ],
          ),
          appBarTitle: vm.model.name,
          collapsingTitle: vm.model.name.toUpperCase(),
          imageUrl: vm.model.image,
        ),
      ),
    );
  }

  Widget _buildText(String text) => Padding(
        padding: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 80),
        child: Text(
          text,
          style: textRegular16.copyWith(
            color: AppColorScheme.colorBlack9,
          ),
        ),
      );

  Widget _buildButton(_ViewModel vm) => Align(
        alignment: Alignment.bottomCenter,
        child: ActionButton(
          padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          text: S.of(context).done.toUpperCase(),
          textColor: AppColorScheme.colorPrimaryWhite,
          color: AppColorScheme.colorPurple2,
          onPressed: () {
            _recentUpdateWisdomRequest = () => vm.onCompleteReadWisdomAction(widget.progressPageIndex);
            _recentUpdateWisdomRequest.call();
          },
        ),
      );
}

class _ViewModel {
  Function(int) onCompleteReadWisdomAction;
  WisdomModel model;
  WisdomPageState wisdomPageState;

  _ViewModel({
    @required this.model,
    @required this.onCompleteReadWisdomAction,
    @required this.wisdomPageState,
  });

  static _ViewModel fromStore(Store<AppState> store, int progressPageIndex) {
    return _ViewModel(
      model: store.state.mainPageState.progressPages[progressPageIndex].wisdomModel,
      wisdomPageState: store.state.mainPageState.wisdomPageState,
      onCompleteReadWisdomAction: (index) {
        store.dispatch(SaveWisdomResultAction(progressPageIndex: index));
      },
    );
  }
}
