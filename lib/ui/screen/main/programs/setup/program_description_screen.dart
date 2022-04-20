import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/exception/idle_exception.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/choose_program/feed_program_list_item.dart';
import 'package:totalfit/redux/actions/program_setup_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:ui_kit/ui_kit.dart';

class ProgramDescriptionPage extends StatefulWidget {
  @override
  _ProgramDescriptionPageState createState() => _ProgramDescriptionPageState();
}

class _ProgramDescriptionPageState extends State<ProgramDescriptionPage> {
  ScrollController _controller;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        onInit: (store) {
          _controller = ScrollController();
        },
        onDispose: (store) {
          _controller.dispose();
        },
        converter: _ViewModel.fromStore,
        onWillChange: (oldVm, newVm) async {
          if (newVm.error is! IdleException) {
            _handleError(newVm);
          }
        },
        builder: (context, vm) => _buildContent(vm));
  }

  Future<void> _handleError(_ViewModel vm) async {
    vm.clearError();

    final attrs = TfDialogAttributes(
      title: S.of(context).dialog_error_title,
      description: vm.error.getMessage(context),
      negativeText: S.of(context).dialog_error_recoverable_negative_text,
      positiveText: S.of(context).all__retry,
    );
    final result = await TfDialog.show(context, attrs);
    if (result is Confirm) {
      vm.onStopProgram();
    }
  }

  Widget _buildContent(_ViewModel vm) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColorScheme.colorBlack,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Stack(
            children: <Widget>[
              _body(vm),
              _setupButton(vm),
              _progressIndicator(vm),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(_ViewModel vm) => Column(
        children: <Widget>[
          _header(vm),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _goal(vm),
                  Container(height: 24),
                  Container(
                    padding: const EdgeInsets.only(left: 16, top: 7, right: 16, bottom: 7),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      S.of(context).program_description__info,
                      style: title20.copyWith(
                        color: AppColorScheme.colorPrimaryWhite,
                      ),
                    ),
                  ),
                  _infoCell(ProgramInfoIcons.progress, vm.program.levelsForFeedUI),
                  _infoCell(ProgrammsIcon2.dumpbell, vm.program.equipmentForFeedUI),
                  SizedBox(height: 70.0)
                ],
              ),
            ),
          )
        ],
      );

  Widget _infoCell(IconData icon, String text) => Padding(
        padding: const EdgeInsets.only(left: 16, top: 7, right: 16, bottom: 7),
        child: Row(
          children: <Widget>[
            Icon(icon, color: AppColorScheme.colorPrimaryWhite),
            Container(width: 12),
            Expanded(
              child: Text(
                text,
                style: textRegular16.copyWith(
                  color: AppColorScheme.colorPrimaryWhite,
                ),
              ),
            ),
          ],
        ),
      );

  Widget _goal(_ViewModel vm) => Padding(
        padding: const EdgeInsets.only(left: 16, top: 24, right: 16),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                S.of(context).program_description__goal,
                style: title20.copyWith(
                  color: AppColorScheme.colorPrimaryWhite,
                ),
              ),
            ),
            Container(height: 4),
            Text(
              vm.program.goal,
              style: textRegular16.copyWith(
                color: AppColorScheme.colorPrimaryWhite,
              ),
            ),
          ],
        ),
      );

  Widget _header(_ViewModel vm) => Container(
        height: 232,
        child: Stack(
          fit: StackFit.expand,
          children: [
            TfImage(
              url: vm.program.image,
              dim: AppColorScheme.colorPrimaryBlack,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                    AppColorScheme.colorBlack,
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.all(16),
              child: Text(
                vm.program.name.toUpperCase(),
                style: title20.copyWith(
                  color: AppColorScheme.colorPrimaryWhite,
                ),
              ),
            ),
            Positioned(
                left: 12.0,
                child: SafeArea(
                  child: IconBackCircleWidget(action: () => Navigator.of(context).pop()),
                ))
            //_backArrow(),
          ],
        ),
      );

  Widget _setupButton(_ViewModel vm) => Align(
        alignment: Alignment.bottomCenter,
        child: ActionButton(
          text: S.of(context).program_description__setup.toUpperCase(),
          color: AppColorScheme.colorYellow,
          textColor: AppColorScheme.colorPrimaryBlack,
          padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
          onPressed: () {
            if (vm.hasActiveProgram) {
              _confirmStopProgram(vm);
            } else {
              vm.continueSetup(vm.program.id);
            }
          },
        ),
      );

  Future<bool> _confirmStopProgram(_ViewModel vm) async {
    final attrs = TfDialogAttributes(
      description: S.of(context).dialog__quit_your_current_program,
      positiveText: S.of(context).all__quit,
      negativeText: S.of(context).all__dont,
    );
    final result = await TfDialog.show(context, attrs);
    if (result is Confirm) {
      vm.onStopProgram();
    }
    return Future.sync(() => false);
  }

  _progressIndicator(_ViewModel vm) {
    return vm.isLoading
        ? Container(color: AppColorScheme.colorPrimaryBlack, child: const CircularLoadingIndicator())
        : const SizedBox.shrink();
  }
}

class _ViewModel {
  final Function() onStopProgram;
  final Function(String) continueSetup;
  final bool isLoading;
  final bool hasActiveProgram;
  final Function clearError;
  final TfException error;
  final FeedProgramListItem program;

  _ViewModel({
    this.onStopProgram,
    this.continueSetup,
    this.isLoading,
    this.clearError,
    this.error,
    this.program,
    this.hasActiveProgram,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      program: store.state.programSetupState.program,
      error: store.state.programSetupState.error,
      isLoading: store.state.programSetupState.showLoading,
      hasActiveProgram: store.state.programProgressState.activeProgram != null,
      continueSetup: (id) => store.dispatch(NavigateToChooseProgramLevelPageAction()),
      onStopProgram: () => store.dispatch(OnStopProgramClickAction()),
      clearError: () => store.dispatch(OnClearProgramsErrorAction()),
    );
  }
}
