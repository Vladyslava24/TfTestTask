import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/story_model.dart';
import 'package:totalfit/redux/actions/main_page_action.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:ui_kit/ui_kit.dart';

class StoryPage extends StatefulWidget {
  final int progressPageIndex;

  StoryPage({@required this.progressPageIndex});

  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: (store) => _ViewModel.fromStore(store, widget.progressPageIndex),
        builder: (context, vm) => _buildContent(vm));
  }

  Widget _buildContent(_ViewModel vm) {
    return Scaffold(
      backgroundColor: AppColorScheme.colorBlack,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: CustomSliverAppBar(
            backButtonIcon: IconBackWidget(
              iconColor: AppColorScheme.colorBlue2,
              action: () => Navigator.of(context).pop(),
            ),
            sliverContent: SliverToBoxAdapter(child: _buildText(vm.model.story)),
            extraOverlayContent: _buildButton(vm),
            appBarTitle: vm.model.name,
            collapsingTitle: vm.model.name.toUpperCase(),
            imageUrl: vm.model.image),
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
          color: AppColorScheme.colorBlue2,
          onPressed: () => vm.onCompleteReadStoryAction(widget.progressPageIndex),
        ),
      );
}

class _ViewModel {
  Function(int) onCompleteReadStoryAction;
  StoryModel model;

  _ViewModel({@required this.model, @required this.onCompleteReadStoryAction});

  static _ViewModel fromStore(Store<AppState> store, int progressPageIndex) {
    return _ViewModel(
      model: store.state.mainPageState.progressPages[progressPageIndex].storyModel,
      onCompleteReadStoryAction: (index) => store.dispatch(
        OnCompleteReadStoryAction(progressPageIndex: index),
      ),
    );
  }
}
