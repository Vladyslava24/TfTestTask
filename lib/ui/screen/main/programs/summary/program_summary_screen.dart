import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/data/dto/response/finish_program_response.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/model/skill_summary_list_items.dart';
import 'package:totalfit/redux/actions/navigation_actions.dart';
import 'package:totalfit/redux/actions/program_progress_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/screen/main/workout/summary/list_item_widgets.dart';
import 'package:ui_kit/ui_kit.dart';

import 'list_item_widgets.dart';

class ProgramSummaryScreen extends StatefulWidget {
  final FinishProgramResponse response;

  ProgramSummaryScreen(this.response);

  @override
  _ProgramSummaryScreenState createState() => _ProgramSummaryScreenState();
}

class _ProgramSummaryScreenState extends State<ProgramSummaryScreen> {
  final _listItems = [];
  ConfettiController _controllerCenter;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        onInit: (store) {
          _listItems.addAll(_buildItemListModels(widget.response));
          _controllerCenter = ConfettiController(duration: const Duration(seconds: 5));
          _controllerCenter.addListener(() {
            setState(() {});
          });
          Future.delayed(Duration(milliseconds: 250), () {
            if (mounted) {
              _controllerCenter.play();
            }
          });
        },
        onDispose: (store) {
          _controllerCenter.dispose();
        },
        distinct: true,
        converter: _ViewModel.fromStore,
        builder: (context, vm) => _buildContent(vm));
  }

  Widget _buildContent(_ViewModel vm) => Scaffold(
        backgroundColor: AppColorScheme.colorBlack,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Stack(
            children: [
              _buildItemList(vm),
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _controllerCenter,
                  blastDirection: pi / 2,
                  particleDrag: 0.025,
                  emissionFrequency: 0.05,
                  numberOfParticles: 20,
                  gravity: 0.05,
                  shouldLoop: false,
                  colors: const [
                    AppColorScheme.colorOrange,
                    AppColorScheme.colorBlue2,
                    AppColorScheme.colorPurple2,
                    AppColorScheme.colorYellow,
                  ], // manually specify the colors to be used
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildItemList(_ViewModel vm) {
    return Material(
      color: AppColorScheme.colorBlack,
      child: Stack(
        children: [
          Positioned.fill(
            child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: _listItems.length,
                itemBuilder: (context, index) {
                  final item = _listItems[index];
                  if (item is HeaderItem) {
                    return ProgramSummaryHeaderWidget(item: item);
                  }
                  if (item is StatisticItem) {
                    return StatisticItemWidget(item: item);
                  }
                  if (item is ProgramSummarySkillHeaderItem) {
                    return ProgramSummarySkillHeaderItemWidget();
                  }
                  if (item is ProgramSummarySkillItem) {
                    return ProgramSummarySkillItemWidget(item: item);
                  }
                  if (item is ListBottomPaddingItem) {
                    return ListBottomPadding();
                  }

                  return SizedBox.shrink();
                }),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              children: [
                Expanded(
                  child: ActionButton(
                    padding: EdgeInsets.only(left: 16, bottom: 16, right: 8),
                    text: S.of(context).share.toUpperCase(),
                    textColor: AppColorScheme.colorYellow,
                    color: AppColorScheme.colorBlack2,
                    onPressed: () => vm.navigateToProgramShareResultPage(widget.response),
                  ),
                ),
                Expanded(
                  child: ActionButton(
                    padding: EdgeInsets.only(left: 8, bottom: 16, right: 16),
                    text: S.of(context).all__finish.toUpperCase(),
                    color: AppColorScheme.colorYellow,
                    onPressed: () => vm.onProgramFinished(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ViewModel {
  Function(FinishProgramResponse) navigateToProgramShareResultPage;
  Function onProgramFinished;

  _ViewModel({@required this.navigateToProgramShareResultPage, @required this.onProgramFinished});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        onProgramFinished: () => store.dispatch(OnProgramFinishedAction()),
        navigateToProgramShareResultPage: (response) => store.dispatch(NavigateToProgramShareResultPage(response)));
  }
}

List<dynamic> _buildItemListModels(FinishProgramResponse response) {
  final listItems = [];
  listItems.add(HeaderItem(image: response.image, name: response.name));
  final statisticItem = StatisticItem(
      points: response.points,
      workoutCount: response.workoutsDone,
      totalExerciseCount: response.exercisesDone,
      totalMinutes: response.workoutsDuration);

  listItems.add(statisticItem);
  listItems.add(ProgramSummarySkillHeaderItem());
  response.learnedSkills.forEach((e) {
    listItems.add(ProgramSummarySkillItem(name: e.name, image: e.previewImage));
  });

  listItems.add(ListBottomPaddingItem());

  return listItems;
}

class HeaderItem {
  final String image;
  final String name;

  HeaderItem({@required this.image, @required this.name});
}

class StatisticItem {
  final int points;
  final int workoutCount;
  final int totalExerciseCount;
  final int totalMinutes;

  StatisticItem({
    @required this.points,
    @required this.workoutCount,
    @required this.totalExerciseCount,
    @required this.totalMinutes,
  });
}

class ProgramSummarySkillHeaderItem {}

class ProgramSummarySkillItem {
  final String name;
  final String image;

  ProgramSummarySkillItem({@required this.name, @required this.image});
}
